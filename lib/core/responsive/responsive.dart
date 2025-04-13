import 'package:flutter/material.dart';

/// A responsive layout widget that displays different content based on screen size.
class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.desktop,
    this.largeTablet,
    this.tablet,
    this.mobileLarge,
    required this.mobile,
  });

  final Widget desktop;
  final Widget? largeTablet;
  final Widget? tablet;
  final Widget? mobileLarge;
  final Widget mobile;

  /// Device size breakpoints
  static const double kExtraSmallMaxWidth = 375;
  static const double kMobileMaxWidth = 450;
  static const double kMobileLargeMaxWidth = 600;
  static const double kTabletMinWidth = 768;
  static const double kTabletMaxWidth = 1024;
  static const double kLargeTabletMaxWidth = 1280;
  static const double kDesktopMinWidth = 1024;

  /// Returns true if the screen width is >= 1024px (desktop)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= kDesktopMinWidth;
  }

  /// Returns true if the screen width is >= 1024px and < 1280px (large tablet)
  static bool isLargeTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= kDesktopMinWidth &&
        MediaQuery.of(context).size.width < kLargeTabletMaxWidth;
  }

  /// Returns true if the screen width is >= 768px and < 1024px (tablet)
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= kTabletMinWidth &&
        MediaQuery.of(context).size.width < kTabletMaxWidth;
  }

  /// Returns true if the screen width is >= 600px and < 768px (large mobile)
  static bool isMobileLarge(BuildContext context) {
    return MediaQuery.of(context).size.width >= kMobileLargeMaxWidth &&
        MediaQuery.of(context).size.width < kTabletMinWidth;
  }

  /// Returns true if the screen width is >= 450px and < 600px (medium mobile)
  static bool isMobileMedium(BuildContext context) {
    return MediaQuery.of(context).size.width >= kMobileMaxWidth &&
        MediaQuery.of(context).size.width < kMobileLargeMaxWidth;
  }

  /// Returns true if the screen width is < 450px (small mobile)
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < kMobileMaxWidth;
  }

  /// Returns true if the screen width is < 375px (extra small mobile)
  static bool isExtraSmall(BuildContext context) {
    return MediaQuery.of(context).size.width < kExtraSmallMaxWidth;
  }

  /// Returns the appropriate text size based on device size
  static double getTextSize({
    required BuildContext context,
    required double extraSmallSize,
    required double mobileSize,
    required double mobileMediumSize,
    required double mobileLargeSize,
    required double tabletSize,
    required double largeTabletSize,
    required double desktopSize,
  }) {
    if (isExtraSmall(context)) return extraSmallSize;
    if (isMobile(context)) return mobileSize;
    if (isMobileMedium(context)) return mobileMediumSize;
    if (isMobileLarge(context)) return mobileLargeSize;
    if (isTablet(context)) return tabletSize;
    if (isLargeTablet(context)) return largeTabletSize;
    return desktopSize;
  }

  /// Returns a value from appropriate breakpoint mapping
  static T getValueForScreenSize<T>({
    required BuildContext context,
    required T extraSmall,
    required T mobile,
    required T mobileMedium,
    required T mobileLarge,
    required T tablet,
    required T largeTablet,
    required T desktop,
  }) {
    if (isExtraSmall(context)) return extraSmall;
    if (isMobile(context)) return mobile;
    if (isMobileMedium(context)) return mobileMedium;
    if (isMobileLarge(context)) return mobileLarge;
    if (isTablet(context)) return tablet;
    if (isLargeTablet(context)) return largeTablet;
    return desktop;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (size.width >= kDesktopMinWidth) {
      return desktop;
    } else if (size.width >= kTabletMaxWidth && largeTablet != null) {
      return largeTablet!;
    } else if (size.width >= kTabletMinWidth && tablet != null) {
      return tablet!;
    } else if (size.width >= kMobileLargeMaxWidth && mobileLarge != null) {
      return mobileLarge!;
    } else {
      return mobile;
    }
  }
}

/// Enum representing different device types
enum DeviceType {
  extraSmall,
  mobile,
  mobileMedium,
  mobileLarge,
  tablet,
  largeTablet,
  desktop,
}

/// Get the device type based on screen width
DeviceType getDeviceType(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  if (width >= Responsive.kDesktopMinWidth) {
    return DeviceType.desktop;
  } else if (width >= Responsive.kTabletMaxWidth) {
    return DeviceType.largeTablet;
  } else if (width >= Responsive.kTabletMinWidth) {
    return DeviceType.tablet;
  } else if (width >= Responsive.kMobileLargeMaxWidth) {
    return DeviceType.mobileLarge;
  } else if (width >= Responsive.kMobileMaxWidth) {
    return DeviceType.mobileMedium;
  } else if (width >= Responsive.kExtraSmallMaxWidth) {
    return DeviceType.mobile;
  } else {
    return DeviceType.extraSmall;
  }
}

/// Extension on BuildContext to easily access responsive methods
extension ResponsiveExtension on BuildContext {
  bool get isDesktop => Responsive.isDesktop(this);
  bool get isLargeTablet => Responsive.isLargeTablet(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isMobileLarge => Responsive.isMobileLarge(this);
  bool get isMobileMedium => Responsive.isMobileMedium(this);
  bool get isMobile => Responsive.isMobile(this);
  bool get isExtraSmall => Responsive.isExtraSmall(this);
  DeviceType get deviceType => getDeviceType(this);
}
