abstract class KnobNodeBase<T> {
  const KnobNodeBase({
    required this.key,
    this.description,
    required this.value,
  }) : super();

  final String key;
  final String? description;
  final T value;

  KnobNodeBase<T> copyWith({
    T? value,
  });
}