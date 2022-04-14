import 'knob_node_base.dart';

/// Number knob node class.
class KnobNodeNumber<T extends num> extends KnobNodeBase<T> {
  KnobNodeNumber({
    required String key,
    String? description,
    required T value,
    required this.min,
    required this.max,
  }) : super(
          key: key,
          description: description,
          value: value,
        );

  final T min;
  final T max;

  @override
  KnobNodeBase<T> copyWithValue({T? value}) {
    return KnobNodeNumber<T>(
      key: key,
      description: description,
      value: value ?? this.value,
      min: min,
      max: max,
    );
  }
}
