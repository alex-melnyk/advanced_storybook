import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class KnobTextWidget extends StatelessWidget {
  const KnobTextWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  final KnobNodeText knobNode;

  @override
  Widget build(BuildContext context) {
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    return ListTile(
      title: TextFormField(
        decoration: InputDecoration(
          isDense: false,
          labelText: knobNode.key,
          border: const OutlineInputBorder(),
        ),
        initialValue: knobNode.value,
        onChanged: (value) {
          knobsProvider.knobStore.updateStoryKnobValue(
            storyProvider.story.key,
            knobKey: knobNode.key,
            newValue: value,
          );
        },
      ),
      subtitle:
          knobNode.description != null ? Text(knobNode.description!) : null,
    );
  }
}
