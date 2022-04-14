import 'package:flutter/widgets.dart';

import 'knob_store.dart';

/// Knob Store provider.
class KnobsProvider extends InheritedWidget {
  const KnobsProvider({
    Key? key,
    required this.knobStore,
    required Widget child,
  }) : super(key: key, child: child);

  /// KnobStore value.
  final KnobStore knobStore;

  /// Gets [KnobsProvider] from context.
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
