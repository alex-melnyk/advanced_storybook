import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class KnobSliderWidget extends StatelessWidget {
  const KnobSliderWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  final KnobNodeNumber knobNode;

  @override
  Widget build(BuildContext context) {
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    final displayValue = knobNode.value is double ? knobNode.value.toStringAsFixed(2) : knobNode.value.toString();

    return ListTile(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${knobNode.key} [$displayValue]'),
          Slider(
            value: knobNode.value.toDouble(),
            min: knobNode.min.toDouble(),
            max: knobNode.max.toDouble(),
            onChanged: (value) {
              knobsProvider.knobStore.updateStoryKnobValue(
                storyProvider.story.key,
                knobKey: knobNode.key,
                newValue: knobNode.value is double ? value : value.toInt(),
              );
            },
          ),
        ],
      ),
      subtitle:
          knobNode.description != null ? Text(knobNode.description!) : null,
    );
  }
}
