import 'knob_node_base.dart';

class KnobNodeText extends KnobNodeBase<String> {
  KnobNodeText({
    required String key,
    String? description,
    required String value,
  }) : super(
    key: key,
    description: description,
    value: value,
  );

  @override
  KnobNodeBase<String> copyWithValue({String? value}) {
    return KnobNodeText(
      key: key,
      description: description,
      value: value ?? this.value,
    );
  }
}