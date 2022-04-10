import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:flutter/widgets.dart';

extension Knob on BuildContext {
  /// Creates [bool] knob.
  bool boolean({
    required String key,
    String? description,
    required bool initial,
  }) {
    final knobProvider = KnobsProvider.of(this);
    final storyProvider = StoryProvider.of(this);

    final knobNode = knobProvider.knobStore.addStoryKnob(
      storyProvider.story.key,
      knobKey: key,
      knobNode: KnobNodeBool(
        key: key,
        description: description,
        value: initial,
      ),
    );

    return knobNode.value;
  }

  /// Creates [int] or [double] knob.
  T number<T extends num>({
    required String key,
    String? description,
    required T initial,
    required T min,
    required T max,
  }) {
    final knobProvider = KnobsProvider.of(this);
    final storyProvider = StoryProvider.of(this);

    final knobNode = knobProvider.knobStore.addStoryKnob(
      storyProvider.story.key,
      knobKey: key,
      knobNode: KnobNodeNumber<T>(
        key: key,
        description: description,
        min: min,
        max: max,
        value: initial,
      ),
    );

    return knobNode.value;
  }

  /// Creates [String] knob.
  String string({
    required String key,
    String? description,
    required String initial,
  }) {
    final knobProvider = KnobsProvider.of(this);
    final storyProvider = StoryProvider.of(this);

    final knobNode = knobProvider.knobStore.addStoryKnob(
      storyProvider.story.key,
      knobKey: key,
      knobNode: KnobNodeText(
        key: key,
        description: description,
        value: initial,
      ),
    );

    return knobNode.value;
  }

  /// Creates [Option] knob.
  T options<T>({
    required String key,
    String? description,
    required List<Option<T>> options,
    int initialIndex = 0,
  }) {
    final knobProvider = KnobsProvider.of(this);
    final storyProvider = StoryProvider.of(this);

    final knobNode = knobProvider.knobStore.addStoryKnob(
      storyProvider.story.key,
      knobKey: key,
      knobNode: KnobNodeOptions<T>(
        key: key,
        description: description,
        options: options,
        value: options[initialIndex],
      ),
    );

    return knobNode.value.value;
  }
}
