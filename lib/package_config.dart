class PackageConfig {
  static String? _databaseName;
  static String? _tableName;

  static void configure({
    required String databaseName,
    required String tableName,
  }) {
    _databaseName = databaseName;
    _tableName = tableName;
  }

  static String get databaseName {
    if (_databaseName == null) throw Exception('PackageConfig not configured');
    return _databaseName!;
  }

  static String get tableName {
    if (_tableName == null) throw Exception('PackageConfig not configured');
    return _tableName!;
  }
}
