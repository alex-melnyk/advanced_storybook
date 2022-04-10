import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:flutter/foundation.dart';

class KnobStore extends ChangeNotifier
    implements ValueListenable<Map<String, Map<String, KnobNodeBase>>> {
  KnobStore() : super();

  Map<String, Map<String, KnobNodeBase>> _value = {};

  @override
  Map<String, Map<String, KnobNodeBase>> get value => _value;

  void clearValues() {
    _value = {};
    notifyListeners();
  }

  Map<String, KnobNodeBase> storyKnobs(String storyKey) {
    return _value[storyKey] ?? {};
  }

  T addStoryKnob<T extends KnobNodeBase>(
    String storyKey, {
    required String knobKey,
    required T knobNode,
  }) {
    if (_value.containsKey(storyKey)) {
      final knobs = _value[storyKey]!;

      if (!knobs.containsKey(knobKey)) {
        knobs[knobKey] = knobNode;
      }
    } else {
      _value[storyKey] = {
        knobKey: knobNode,
      };
    }

    return _value[storyKey]![knobKey]! as T;
  }

  void updateStoryKnobValue<T>(
    String storyKey, {
    required String knobKey,
    required T newValue,
  }) {
    final updatedKnob = _value[storyKey]![knobKey]!.copyWithValue(
      value: newValue,
    );

    _value = Map.of(_value)..[storyKey]![knobKey] = updatedKnob;

    notifyListeners();
  }
}
