import 'package:flutter/material.dart';

/// AdaptiveLayout for adaptive ui.
class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        /// If our [constraints.maxWidth] is more than 1100 then we consider it a desktop.
        if (constraints.maxWidth >= 1100) {
          return desktop;
        }

        /// If [constraints.maxWidth] it less then 1100 and more then 650 we consider it as tablet.
        if (constraints.maxWidth < 1100 && constraints.maxWidth >= 650) {
          return tablet;
        }

        /// Or less then that we called it mobile.
        return mobile;
      },
    );
  }
}
