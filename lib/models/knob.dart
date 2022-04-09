import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

extension Knob on BuildContext {
  String string({
    required String key,
    String? description,
    required String value,
  }) {
    final currentStory = StoryProvider.of(this).story;
    final knobsProvider = KnobsProvider.of(this);

    final storyKey = currentStory.path;
    final knobs = knobsProvider.knobs;

    if (knobs.containsKey(storyKey)) {
      final values = knobs[storyKey]!;

      if (!values.containsKey(key)) {
        values[key] = KnobValue(
          key: key,
          description: description,
          value: value,
        );
      }
    } else {
      knobs[storyKey] = {
        key: KnobValue(
          key: key,
          description: description,
          value: value,
        ),
      };
    }

    return knobs[storyKey]![key]!.value;
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
