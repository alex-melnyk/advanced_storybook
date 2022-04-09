import 'package:advanced_storybook/models/models.dart';
import 'package:flutter/widgets.dart';

class KnobsProvider extends InheritedWidget {
  KnobsProvider({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final knobs = <String, Map<String, KnobValue>>{};

  static KnobsProvider of(BuildContext context) {
    final KnobsProvider? result =
        context.dependOnInheritedWidgetOfExactType<KnobsProvider>();
    assert(result != null, 'No KnobsProvider found in context');
    return result!;
  }

  Map<String, KnobValue> knobsValuesFor(String storyKey) {
    return knobs[storyKey] ?? {};
  }

  @override
  bool updateShouldNotify(KnobsProvider oldWidget) {
    return knobs != oldWidget.knobs;
  }
}
