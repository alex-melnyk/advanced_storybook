import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class KnobOptionsWidget extends StatelessWidget {
  const KnobOptionsWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  final KnobNodeOptions knobNode;

  @override
  Widget build(BuildContext context) {
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    return ListTile(
      title: DropdownButtonFormField(
        decoration: InputDecoration(
          isDense: true,
          labelText: knobNode.key,
          border: const OutlineInputBorder(),
        ),
        value: knobNode.value,
        items: [
          for (final e in knobNode.options)
            if (e.value is Color)
              DropdownMenuItem(
                value: e,
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: e.value,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Text(
                      e.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            else
              DropdownMenuItem(
                value: e,
                child: Text(
                  e.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        ],
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
