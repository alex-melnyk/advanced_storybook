import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:flutter/material.dart';

/// Checkbox widget for [KnobNodeNumber].
class KnobSliderWidget extends StatelessWidget {
  const KnobSliderWidget({
    Key? key,
    required this.knobNode,
  }) : super(key: key);

  /// Knob node instance.
  final KnobNodeNumber knobNode;

  @override
  Widget build(BuildContext context) {
    final displayValue = knobNode.value is double
        ? knobNode.value.toStringAsFixed(2)
        : knobNode.value.toString();

    return ListTile(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${knobNode.title} [$displayValue]'),
          Slider(
            value: knobNode.value.toDouble(),
            min: knobNode.min.toDouble(),
            max: knobNode.max.toDouble(),
            onChanged: (value) => _handleOnChanged(
              context,
              value: value,
            ),
          ),
        ],
      ),
      subtitle:
          knobNode.description != null ? Text(knobNode.description!) : null,
    );
  }

  void _handleOnChanged(
    BuildContext context, {
    required double value,
  }) {
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    knobsProvider.knobStore.updateStoryKnobValue(
      storyProvider.story.key,
      knobKey: knobNode.key,
      newValue: knobNode.value is double ? value : value.toInt(),
    );
  }
}
