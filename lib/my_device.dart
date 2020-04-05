// import 'dart:io';
// // import 'package:device_info/device_info.dart';
// import 'package:flutter/foundation.dart';

// // helper class to get my device name
// class MyDevice with ChangeNotifier {
//   // Constructor
//   MyDevice() {
//     _setup();
//   }
//   //
//   // instance properties
//   String _name;
//   String get name => _name;
//   //
//   // transient properties
//   bool _isWaiting = true;
//   bool get isWaiting => _isWaiting;
//   //
//   void _setup() async {
//     final devInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       final androidInfo = await devInfo.androidInfo;
//       _name = androidInfo.host;
//     } else if (Platform.isIOS) {
//       final iosInfo = await devInfo.iosInfo;
//       _name = iosInfo.name;
//     } else {
//       _name = 'Other';
//     }
//     _isWaiting = false;
//     notifyListeners();
//   }
// }
