import 'dart:ui';

class Option<T> {
  const Option({
    this.key,
    this.description,
    required this.value,
  });

  final String? key;
  final String? description;
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
