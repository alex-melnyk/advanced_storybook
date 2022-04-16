import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:flutter/material.dart';

/// Checkbox widget for [KnobNodeOptions].
class KnobOptionsWidget extends StatelessWidget {
  const KnobOptionsWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  /// Knob node instance.
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
        onChanged: (value) => _handleOnChanged(
          context,
          value: value,
        ),
      ),
      subtitle:
          knobNode.description != null ? Text(knobNode.description!) : null,
    );
  }

  void _handleOnChanged(
    BuildContext context, {
    required Object? value,
  }) {
    final storybookProvider = StorybookProvider.of(context);

    storybookProvider.knobStore.updateStoryKnobValue(
      storybookProvider.currentStory!.key,
      knobKey: knobNode.key,
      newValue: value,
    );
  }
}
