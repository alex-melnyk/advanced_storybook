import 'package:advanced_storybook/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class KnobsProvider extends InheritedWidget {
  const KnobsProvider({
    Key? key,
    required this.knobStore,
    required Widget child,
  }) : super(key: key, child: child);

  final KnobStore knobStore;

  static KnobsProvider of(BuildContext context) {
    final KnobsProvider? result =
        context.dependOnInheritedWidgetOfExactType<KnobsProvider>();
    assert(result != null, 'No KnobsProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(KnobsProvider oldWidget) {
    return knobStore != oldWidget.knobStore;
  }
}

class KnobStore extends ChangeNotifier
    implements ValueListenable<Map<String, Map<String, KnobValue>>> {
  KnobStore() : super();

  Map<String, Map<String, KnobValue>> _value = {};

  @override
  Map<String, Map<String, KnobValue>> get value => _value;

  Map<String, KnobValue> storyKnobs(String storyKey) {
    return value[storyKey] ?? {};
  }

  KnobValue addStoryKnob(
    String storyKey, {
    required String knobKey,
    required KnobValue knobValue,
  }) {
    if (value.containsKey(storyKey)) {
      final knobs = value[storyKey]!;

      if (!knobs.containsKey(knobKey)) {
        knobs[knobKey] = knobValue;
      }
    } else {
      value[storyKey] = {
        knobKey: knobValue,
      };
    }

    return value[storyKey]![knobKey]!;
  }

  void updateStoryKnobValue(
    String storyKey, {
    required String knobKey,
    required String newValue,
  }) {
    final updatedValue = Map.of(_value)..[storyKey]![knobKey]!.value = newValue;

    _value = updatedValue;

    notifyListeners();
  }
}
