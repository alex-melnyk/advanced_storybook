import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:flutter/material.dart';

class KnobOptionsWidget extends StatelessWidget {
  const KnobOptionsWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  final KnobNodeOptions knobNode;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: DropdownButtonFormField(
        decoration: InputDecoration(
          isDense: true,
          labelText: knobNode.title,
          border: const OutlineInputBorder(),
        ),
        value: knobNode.value,
        items: [
          for (final option in knobNode.options)
            if (option.value is Color)
              DropdownMenuItem(
                value: option,
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: option.value,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Text(
                      option.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            else
              DropdownMenuItem(
                value: option,
                child: Text(
                  option.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        ],
        onChanged: (value) => handleOnChanged(
          context,
          value: value,
        ),
      ),
      subtitle:
          knobNode.description != null ? Text(knobNode.description!) : null,
    );
  }

  void handleOnChanged(BuildContext context, {required Object? value}) {
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    knobsProvider.knobStore.updateStoryKnobValue(
      storyProvider.story.key,
      knobKey: knobNode.key,
      newValue: value,
    );
  }
}
