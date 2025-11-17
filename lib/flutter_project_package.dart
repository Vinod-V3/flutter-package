// library flutter_project_package;

import 'package:flutter/material.dart';
import './pages/page_one.dart';
// import './pages/page_two.dart';
import './config/app_config.dart';
import 'package:easy_localization/easy_localization.dart';

class FlutterProjectPackage extends StatefulWidget {
  final Map<String, dynamic> config;
  const FlutterProjectPackage({super.key, required this.config});

  @override
  State<FlutterProjectPackage> createState() => _FlutterProjectPackageState();
}

class _FlutterProjectPackageState extends State<FlutterProjectPackage> {
  @override
  void initState() {
    super.initState();
    AppConfig.instance.initialize(widget.config);
  }

  // static Future<void> openPageOne(
  //   BuildContext context, {
  //   Map<String, dynamic>? data,
  // }) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => PageOne(data: {'id':"11111"}),
  //     ),
  //   );
  // }

  @override
  // Widget build(BuildContext context) {
  //   return ElevatedButton(
  //     onPressed: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => const PageOne()),
  //       );
  //     },
  //     // child: const Text('Go to Page One'),
  //     child: Text('package_button'.tr()),
  //     // child: Text('package:flutter_project_package.package_page_one'.tr()),
  //   );
  // }
  Widget build(BuildContext context) {
    debugPrint("CONTEXT DATA: $context");
    return EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi')],
      // path: 'assets/translations',
      path: 'packages/flutter_project_package',
      fallbackLocale: const Locale('en'),
      assetLoader: const RootBundleAssetLoader(),
      startLocale: context.locale, // inherit current locale from parent
      child: Builder(
        builder: (context) {
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PageOne(data: {'id': "11111"}),
                ),
              );
            },
            child: Text('package_page_one'.tr()),
          );
        },
      ),
    );
  }
}

// class FlutterProjectPackage extends StatelessWidget {
//   const FlutterProjectPackage({super.key});

//   @override
//     Widget build(BuildContext context) {
//       return ElevatedButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const PageOne()),
//           );
//         },
//         child: const Text('Go to Page One'),
//       );
//     }
//   // Widget build(BuildContext context) {
//   //   return MaterialApp(
//   //     initialRoute: '/',
//   //     routes: {
//   //       '/': (context) => const _HomePage(),
//   //       '/page-one': (context) => const PageOne(),
//   //       '/page-two': (context) => const PageTwo(),
//   //     },
//   //     debugShowCheckedModeBanner: false,
//   //   );
//   // }
// }

// class _HomePage extends StatelessWidget {
//   const _HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Package Home')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Navigator.pushNamed(context, '/page-one'),
//           child: const Text('Go to Page One'),
//         ),
//       ),
//     );
//   }
// }

// void launchFlutterPackage(BuildContext context, {
//   required String message,
//   required VoidCallback onButtonPressed,
// }) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const FlutterProjectPackage(),
//       settings: RouteSettings(
//         arguments: _PageTwoArgs(
//           message: message,
//           onButtonPressed: onButtonPressed,
//         ),
//       ),
//     ),
//   );
// }
