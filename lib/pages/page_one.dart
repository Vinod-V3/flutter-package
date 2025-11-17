import 'package:flutter/material.dart';
import './page_two.dart';
import '../config/app_config.dart';
import 'package:easy_localization/easy_localization.dart';

class PageOne extends StatelessWidget {
  final Map<String, String> data;
  const PageOne({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance.all;
    // You can pass arguments here if needed
    return Scaffold(
      appBar: AppBar(title: const Text('Package Page One')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Base URL: ${config.baseUrl}'),
            // Text('District: ${config.profileData['district']}'),
            // Text('Max File Size: ${config.maxFileSize}MB'),
            // Text('Project ID: ${config.projectData['id']}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PageTwo()),
                );
              },
              child: Text('package_page_two'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint('Data: $config');
                debugPrint('PAssed Data: $data');
              },
              child: const Text('Data'),
            ),
            // Text('change_language'.tr()),
          ],
        ),
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       // Navigate to Page Two
      //       // Navigator.push(
      //       //   context,
      //       //   MaterialPageRoute(
      //       //     builder: (context) => const PageTwo(),
      //       //   ),
      //       // );
      //       Navigator.pushNamed(context, '/page-two');
      //     },
      //     child: const Text('Go to Page Two u'),
      //   ),
      // ),
    );
  }
}
