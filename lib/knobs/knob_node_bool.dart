import 'knob_node_base.dart';

class KnobNodeBool extends KnobNodeBase<bool> {
  KnobNodeBool({
    required String key,
    String? description,
    required bool value,
  }) : super(
          key: key,
          description: description,
          value: value,
        );

  @override
  KnobNodeBase<bool> copyWithValue({
    bool? value,
  }) {
    return KnobNodeBool(
      key: key,
      description: description,
      value: value ?? this.value,
    );
  }
}
