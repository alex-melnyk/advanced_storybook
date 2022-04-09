import 'package:advanced_storybook/knobs/knobs.dart';
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
    implements ValueListenable<Map<String, Map<String, KnobNodeBase>>> {
  KnobStore() : super();

  Map<String, Map<String, KnobNodeBase>> _value = {};

  @override
  Map<String, Map<String, KnobNodeBase>> get value => _value;

  Map<String, KnobNodeBase> storyKnobs(String storyKey) {
    return value[storyKey] ?? {};
  }

  T addStoryKnob<T extends KnobNodeBase>(
    String storyKey, {
    required String knobKey,
    required T knobNode,
  }) {
    if (value.containsKey(storyKey)) {
      final knobs = value[storyKey]!;

      if (!knobs.containsKey(knobKey)) {
        knobs[knobKey] = knobNode;
      }
    } else {
      value[storyKey] = {
        knobKey: knobNode,
      };
    }

    return value[storyKey]![knobKey]! as T;
  }

  void updateStoryKnobValue<T>(
    String storyKey, {
    required String knobKey,
    required T newValue,
  }) {
    final updatedKnob = _value[storyKey]![knobKey]!.copyWith(
      value: newValue,
    );

    _value = Map.of(_value)
      ..[storyKey]![knobKey] = updatedKnob;

    notifyListeners();
  }
}
