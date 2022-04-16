import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:flutter/material.dart';

/// Checkbox widget for [KnobNodeBool].
class KnobCheckboxWidget extends StatelessWidget {
  const KnobCheckboxWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  /// Knob node instance.
  final KnobNodeBool knobNode;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(knobNode.title),
      subtitle:
          knobNode.description != null ? Text(knobNode.description!) : null,
      value: knobNode.value,
      onChanged: (value) => _handleOnChanged(
        context,
        value: value,
      ),
    );
  }

  void _handleOnChanged(
    BuildContext context, {
    required bool? value,
  }) {
    final storybookProvider = StorybookProvider.of(context);

    storybookProvider.knobStore.updateStoryKnobValue(
      storybookProvider.currentStory!.key,
      knobKey: knobNode.key,
      newValue: value,
    );
  }
}
