import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:flutter/widgets.dart';

/// The [BuildContext] class extension.
extension Knob on BuildContext {
  /// Creates [bool] knob.
  bool boolean({
    /// Knob node key.
    required String key,

    /// Knob node description.
    String? description,

    /// Knob node initial value.
    required bool initial,
  }) {
    final storybookProvider = StorybookProvider.of(this);
    final storyProvider = StoryProvider.of(this);

    final knobNode = storybookProvider.knobStore.addStoryKnob(
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
    /// Knob node key.
    required String key,

    /// Knob node description.
    String? description,

    /// Knob node initial value.
    required T initial,

    /// Knob node minimum value.
    required T min,

    /// Knob node maximum value.
    required T max,
  }) {
    final storybookProvider = StorybookProvider.of(this);
    final storyProvider = StoryProvider.of(this);

    final knobNode = storybookProvider.knobStore.addStoryKnob(
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
    /// Knob node key.
    required String key,

    /// Knob node description.
    String? description,

    /// Knob node initial value.
    required String initial,
  }) {
    final storybookProvider = StorybookProvider.of(this);
    final storyProvider = StoryProvider.of(this);

    final knobNode = storybookProvider.knobStore.addStoryKnob(
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
    /// Knob node key.
    required String key,

    /// Knob node description.
    String? description,

    /// Knob node options.
    required List<Option<T>> options,

    /// Knob node initial value index.
    int initialIndex = 0,
  }) {
    final storybookProvider = StorybookProvider.of(this);
    final storyProvider = StoryProvider.of(this);

    final knobNode = storybookProvider.knobStore.addStoryKnob(
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
