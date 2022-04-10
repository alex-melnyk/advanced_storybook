import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:flutter/material.dart';

class KnobTextWidget extends StatelessWidget {
  const KnobTextWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  final KnobNodeText knobNode;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        decoration: InputDecoration(
          isDense: false,
          labelText: knobNode.title,
          border: const OutlineInputBorder(),
        ),
        initialValue: knobNode.value,
        onChanged: (value) => handleOnChanged(
          context,
          value: value,
        ),
      ),
      subtitle:
          knobNode.description != null ? Text(knobNode.description!) : null,
    );
  }

  void handleOnChanged(BuildContext context, {required String value}) {
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    knobsProvider.knobStore.updateStoryKnobValue(
      storyProvider.story.key,
      knobKey: knobNode.key,
      newValue: value,
    );
  }
}
