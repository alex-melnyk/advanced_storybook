import 'package:advanced_storybook/models/models.dart';

import 'knob_node_base.dart';

class KnobNodeOptions<T> extends KnobNodeBase<Option<T>> {
  KnobNodeOptions({
    required String key,
    String? description,
    required Option<T> value,
    required this.options,
  }) : super(
          key: key,
          description: description,
          value: value,
        );

  final List<Option<T>> options;

  @override
  KnobNodeBase<Option<T>> copyWithValue({
    Option<T>? value,
  }) {
    return KnobNodeOptions(
      key: key,
      description: description,
      value: value ?? this.value,
      options: options,
    );
  }
}
