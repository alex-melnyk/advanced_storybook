/// Knob node base class.
abstract class KnobNodeBase<T> {
  const KnobNodeBase({
    required this.key,
    this.description,
    required this.value,
  }) : super();

  /// Knob node key.
  final String key;
  /// Knob node description.
  final String? description;
  /// Knob node value.
  final T value;

  /// Copy this object with a new value.
  KnobNodeBase<T> copyWithValue({
    T? value,
  });

  /// Knob node section name getter.
  String get section {
    final parts = key.split('/');

    if (parts.length > 1) {
      return parts.first;
    }

    return '';
  }

  /// Knob node title name getter.
  String get title {
    final parts = key.split('/');

    if (parts.length > 1) {
      return parts.last;
    }

    return key;
  }

  @override
  String toString() {
    return 'Knob $key: $value';
  }
}
