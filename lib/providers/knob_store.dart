import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:flutter/foundation.dart';

/// Knobs store notifier class.
class KnobStore extends ChangeNotifier
    implements ValueListenable<Map<String, Map<String, KnobNodeBase>>> {
  KnobStore() : super();

  Map<String, Map<String, KnobNodeBase>> _value = {};

  @override
  Map<String, Map<String, KnobNodeBase>> get value => _value;

  /// Clears all knobs.
  void clearValues() {
    _value = {};
    notifyListeners();
  }

  /// Returns knobs by [storyKey].
  Map<String, KnobNodeBase> storyKnobs(String storyKey) {
    return _value[storyKey] ?? {};
  }

  /// Adds knob to story by [storyKey].
  T addStoryKnob<T extends KnobNodeBase>(
    /// Key of the [Story].
    String storyKey, {

    /// Knob node key.
    required String knobKey,

    /// Knob node value.
    required T knobNode,
  }) {
    if (_value.containsKey(storyKey)) {
      final knobs = _value[storyKey]!;

      if (!knobs.containsKey(knobKey)) {
        knobs[knobKey] = knobNode;
        Future.microtask(notifyListeners);
      }
    } else {
      _value[storyKey] = {
        knobKey: knobNode,
      };
      Future.microtask(notifyListeners);
    }

    return _value[storyKey]![knobKey]! as T;
  }

  /// Updates knob by [knobKey] in story by [storyKey].
  void updateStoryKnobValue<T>(
    /// Key of the [Story].
    String storyKey, {

    /// Knob node key.
    required String knobKey,

    /// Knob node new value.
    required T newValue,
  }) {
    final updatedKnob = _value[storyKey]![knobKey]!.copyWithValue(
      value: newValue,
    );

    _value = Map.of(_value)..[storyKey]![knobKey] = updatedKnob;

    notifyListeners();
  }
}
