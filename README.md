# flutter_persistent_cloud

The original "flutter create" app re-written entirely with Stateless Widgets, using Provider to hold the app-state data. And now, also including:
- persistent storage for the app state, via Google Cloud Firestore
- data-sharing, for the state data - run simultaneously in multiple simulators/emulators/devices to see real-time data-sharing
- web ready! Be sure to follow the instructions at https://flutter.dev/docs/get-started/web#set-up to get the supported Flutter version and have web enabled. Then "flutter create ." inside the project folder to create that web subtree. Finally, follow the instructions at https://pub.dev/packages/cloud_firestore for Web. Note that the device_info package is no longer used (as it's not web-ready) and a custom my_platform.dart file has been added to the project instead.

## Getting Started

This project is the third in a series starting from the default Flutter starter app, converting to all-Stateless Widgets, and now adding persistent & shared data via Google Cloud Firestore. The repo for the previous edition is at https://github.com/eggzotic/flutter_persistent_local

This repo, as-is, will not build a working Flutter App. You need to create a Firestore Project, plus DB, access-rules and structure as per the article at https://medium.com/@eggzotic/cloud-based-data-persistence-in-flutter-5fd7f1440f25, followed by adding your iOS &/or Android apps with the accompanying plist/JSON files (all of which is covered in the article) - only then will you have your own fully functioning Flutter app.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Provider Package](https://pub.dev/packages/provider)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Richard Shepherd  
December 2019