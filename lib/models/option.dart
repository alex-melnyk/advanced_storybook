import 'dart:ui';

/// Option representation class.
class Option<T> {
  const Option({
    this.key,
    this.description,
    required this.value,
  });

  /// Option key.
  final String? key;
  /// Option description.
  final String? description;
  /// Option value.
  final T value;

  @override
  String toString() {
    if (value is Color) {
      final hex = (value as Color).value.toRadixString(16).toUpperCase();
      return '#$hex';
    }

    return value.toString();
  }
}
