import 'package:flutter/foundation.dart';

class MyPlatform {
  final PlatformFlavor flavor;
  final String name;
  final bool isMobile;
  //
  MyPlatform._private(this.flavor)
      : name = _name[flavor],
        isMobile = _isMobile[flavor];
  //
  factory MyPlatform() {
    PlatformFlavor flav;
    // this is kinda crappy - should be implemented in Platform or TargetPlatform
    if (kIsWeb) {
      flav = PlatformFlavor.web;
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      flav = PlatformFlavor.windows;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      flav = PlatformFlavor.android;
    } else if (defaultTargetPlatform == TargetPlatform.fuchsia) {
      flav = PlatformFlavor.fuchsia;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      flav = PlatformFlavor.ios;
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      flav = PlatformFlavor.linux;
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      flav = PlatformFlavor.macOs;
    } else {
      flav = PlatformFlavor.unknown;
    }
    return MyPlatform._private(flav);
  }
  //
  static final Map<PlatformFlavor, String> _name = {
    PlatformFlavor.unknown: 'unknown',
    PlatformFlavor.windows: 'Windows',
    PlatformFlavor.android: 'Android',
    PlatformFlavor.fuchsia: 'Fuchsia',
    PlatformFlavor.ios: 'iOS',
    PlatformFlavor.linux: 'Linux',
    PlatformFlavor.macOs: 'Mac OS',
    PlatformFlavor.web: 'Web'
  };
  static final Map<PlatformFlavor, bool> _isMobile = {
    PlatformFlavor.unknown: false,
    PlatformFlavor.windows: false, // not always correct
    PlatformFlavor.android: true,
    PlatformFlavor.fuchsia: true,
    PlatformFlavor.ios: true, // not always correct
    PlatformFlavor.linux: false,
    PlatformFlavor.macOs: false,
    PlatformFlavor.web: false,
  };
}

enum PlatformFlavor {
  unknown,
  windows,
  android,
  fuchsia,
  ios,
  linux,
  macOs,
  web,
}
