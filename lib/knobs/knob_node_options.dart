import 'package:advanced_storybook/models/models.dart';

import 'knob_node_base.dart';

class KnobOptionsNode<T> extends KnobNodeBase<Option<T>> {
  KnobOptionsNode({
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
  KnobNodeBase<Option<T>> copyWith({
    Option<T>? value,
  }) {
    return KnobOptionsNode(
      key: key,
      description: description,
      value: value ?? this.value,
      options: options,
    );
  }
}
