import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class KnobCheckboxWidget extends StatelessWidget {
  const KnobCheckboxWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  final KnobNodeBool knobNode;

  @override
  Widget build(BuildContext context) {
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    return CheckboxListTile(
      title: Text(knobNode.key),
      subtitle:
          knobNode.description != null ? Text(knobNode.description!) : null,
      value: knobNode.value,
      onChanged: (value) {
        knobsProvider.knobStore.updateStoryKnobValue(
          storyProvider.story.key,
          knobKey: knobNode.key,
          newValue: value,
        );
      },
    );
  }
}
