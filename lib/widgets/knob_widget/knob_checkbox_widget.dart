import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:flutter/material.dart';

class KnobCheckboxWidget extends StatelessWidget {
  const KnobCheckboxWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  final KnobNodeBool knobNode;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(knobNode.title),
      subtitle:
          knobNode.description != null ? Text(knobNode.description!) : null,
      value: knobNode.value,
      onChanged: (value) => handleOnChanged(
        context,
        value: value,
      ),
    );
  }

  void handleOnChanged(BuildContext context, {required bool? value}) {
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    knobsProvider.knobStore.updateStoryKnobValue(
      storyProvider.story.key,
      knobKey: knobNode.key,
      newValue: value,
    );
  }
}
