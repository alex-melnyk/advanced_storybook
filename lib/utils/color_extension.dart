import 'dart:ui';

/// The [Color] class extension.
extension ColorExtension on Color {
  /// Builds string in HEX format #FF000000.
  String toHexColor() {
    final hex = value.toRadixString(16).toUpperCase();
    return '#$hex';
  }
}
