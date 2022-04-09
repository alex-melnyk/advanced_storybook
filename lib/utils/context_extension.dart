import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

extension Knob on BuildContext {
  String string({
    required String key,
    String? description,
    required String initial,
  }) {
    return KnobsProvider.of(this)
        .knobStore
        .addStoryKnob(
          StoryProvider.of(this).story.key,
          knobKey: key,
          knobNode: KnobNodeText(
            key: key,
            description: description,
            value: initial,
          ),
        )
        .value;
  }

  T options<T>({
    required String key,
    String? description,
    required List<Option<T>> options,
    int initialIndex = 0,
  }) {
    return KnobsProvider.of(this)
        .knobStore
        .addStoryKnob(
          StoryProvider.of(this).story.key,
          knobKey: key,
          knobNode: KnobOptionsNode<T>(
            key: key,
            description: description,
            options: options,
            value: options[initialIndex],
          ),
        )
        .value
        .value;
  }
}
