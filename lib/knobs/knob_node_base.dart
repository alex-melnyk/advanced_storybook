abstract class KnobNodeBase<T> {
  const KnobNodeBase({
    required this.key,
    this.description,
    required this.value,
  }) : super();

  final String key;
  final String? description;
  final T value;

  KnobNodeBase<T> copyWithValue({
    T? value,
  });

  String get section {
    final parts = key.split('/');

    if (parts.length > 1) {
      return parts.first;
    }

    return '';
  }

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
