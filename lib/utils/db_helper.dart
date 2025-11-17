// import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_project_package/package_config.dart';

class StorageItem {
  final String id;
  final String type;
  final dynamic data;
  final Map<String, dynamic>? metadata;
  final int createdAt;

  StorageItem({
    required this.id,
    required this.type,
    required this.data,
    this.metadata,
    required this.createdAt,
  });
}

class PackageDBHelper {
  static Database? _db;

  static Future<Database> _openDb() async {
    if (_db != null) return _db!;
    final dbName = PackageConfig.databaseName;
    final tableName = PackageConfig.tableName;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            id TEXT PRIMARY KEY,
            type TEXT NOT NULL,
            data BLOB,
            metadata TEXT,
            created_at INTEGER
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<void> insertItem(
    String id,
    String type,
    dynamic data, {
    Map<String, dynamic>? metadata,
  }) async {
    final db = await _openDb();
    dynamic stored;
    switch (type) {
      case 'json':
        stored = utf8.encode(jsonEncode(data));
        break;
      case 'text':
        stored = utf8.encode(data.toString());
        break;
      case 'binary':
      case 'file':
      case 'blob':
        stored = data as Uint8List;
        break;
      default:
        throw Exception('Unsupported type: $type');
    }

    await db.insert(PackageConfig.tableName, {
      'id': id,
      'type': type,
      'data': stored,
      'metadata': jsonEncode(metadata ?? {}),
      'created_at': DateTime.now().millisecondsSinceEpoch,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<StorageItem?> getItem(String id) async {
    final db = await _openDb();
    final res = await db.query(
      PackageConfig.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (res.isEmpty) return null;
    final row = res.first;
    final type = row['type'] as String;
    final Uint8List bytes = row['data'] as Uint8List;
    dynamic decoded;
    switch (type) {
      case 'json':
        decoded = jsonDecode(utf8.decode(bytes));
        break;
      case 'text':
        decoded = utf8.decode(bytes);
        break;
      case 'binary':
      case 'file':
      case 'blob':
        decoded = bytes;
        break;
      default:
        decoded = bytes;
    }
    return StorageItem(
      id: row['id'] as String,
      type: type,
      data: decoded,
      metadata: jsonDecode(row['metadata'] as String),
      createdAt: row['created_at'] as int,
    );
  }

  static Future<void> storeFile(
    String id,
    File file, {
    Map<String, dynamic>? metadata,
  }) async {
    final bytes = await file.readAsBytes();
    await insertItem(
      id,
      'file',
      bytes,
      metadata: {'filename': basename(file.path), ...?metadata},
    );
  }

  static Future<File> saveToFile(StorageItem item, String outputPath) async {
    final f = File(outputPath);
    await f.writeAsBytes(item.data as Uint8List);
    return f;
  }
}
