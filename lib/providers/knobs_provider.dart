import 'package:flutter/widgets.dart';

import 'knob_store.dart';

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
    return true;
  }
}
