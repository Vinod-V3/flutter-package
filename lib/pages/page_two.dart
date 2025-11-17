import 'package:flutter/material.dart';
import '../utils/db_helper.dart';
import 'package:easy_localization/easy_localization.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  Map<String, dynamic>? _json;
  String? _status;

  Future<void> fetchFromSharedDb() async {
    final item = await PackageDBHelper.getItem('684bcd083a0ac2');
    if (item == null) {
      setState(() {
        _status = 'No item found';
      });
      return;
    }
    if (item.type == 'json') {
      setState(() {
        _json = Map<String, dynamic>.from(item.data as Map);
        _status = 'fetched';
      });
    } else {
      setState(() {
        _status = 'Found non-json item';
      });
    }
  }

  Future<void> updateNameFromPackage() async {
    final item = await PackageDBHelper.getItem('684bcd083a0ac2');
    if (item == null || item.type != 'json') return;
    final Map<String, dynamic> data = Map<String, dynamic>.from(item.data);
    data['solutionDetails']['name'] = 'Observation name updated (from package)';
    await PackageDBHelper.insertItem(
      item.id,
      'json',
      data,
      metadata: item.metadata,
    );
    await fetchFromSharedDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('package_page_two'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: fetchFromSharedDb,
              child: const Text('Fetch shared item'),
            ),
            ElevatedButton(
              onPressed: updateNameFromPackage,
              child: const Text('Update name (package)'),
            ),
            const SizedBox(height: 20),
            Text(_status ?? ''),
            if (_json != null) ...[
              Text('Name: ${_json!['solutionDetails']['name']}'),
              Text('SubType: ${_json!['solutionDetails']['subType']}'),
              Text('EntityType: ${_json!['entityType']}'),
            ],
          ],
        ),
      ),
    );
  }
}
