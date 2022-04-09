import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

extension Knob on BuildContext {
  String string({
    required String key,
    String? description,
    required String value,
  }) {
    final knobsProvider = KnobsProvider.of(this);

    final currentStory = StoryProvider.of(this).story;

    final storyKey = currentStory.path;

    final knobValue = knobsProvider.knobStore.addStoryKnob(
      storyKey,
      knobKey: key,
      knobValue: KnobValue(
        key: key,
        description: description,
        value: value,
      ),
    );

    return knobValue.value;
  }
}

class KnobValue extends ValueNotifier<String> {
  final String key;
  final String? description;

  KnobValue({
    required this.key,
    this.description,
    required String value,
  }) : super(value);
}
