import 'package:advanced_storybook/models/models.dart';
import 'package:flutter/widgets.dart';

import 'knob_store.dart';

/// Storybook inherited widget.
class _StorybookInherited extends InheritedWidget {
  const _StorybookInherited({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);

  /// [StorybookProvider] state instance.
  final _StorybookProviderState state;

  /// Gets [_StorybookInherited] from context.
  static _StorybookInherited of(BuildContext context) {
    final _StorybookInherited? result =
        context.dependOnInheritedWidgetOfExactType<_StorybookInherited>();
    assert(result != null, 'No StorybookInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_StorybookInherited oldWidget) {
    return true;
  }

  /// Returns [KnobStore] instance.
  KnobStore get knobStore => state._knobStore;

  /// Returns [Story] instance, or null.
  Story? get currentStory => state._currentStory.value;

  /// Sets [Story] instance, or null.
  set currentStory(Story? story) => state._currentStory.value = story;
}

/// Storybook provider.
class StorybookProvider extends StatefulWidget {
  const StorybookProvider({
    Key? key,
    required this.stories,
    required this.builder,
  }) : super(key: key);

  /// Stories list.
  final List<Story> stories;

  /// Widget builder.
  final WidgetBuilder builder;

  static _StorybookInherited of(BuildContext context) {
    return _StorybookInherited.of(context);
  }

  @override
  _StorybookProviderState createState() => _StorybookProviderState();
}

/// The [StorybookProvider] state.
class _StorybookProviderState extends State<StorybookProvider> {
  /// Knobs store.
  final _knobStore = KnobStore();

  /// Current [Story] isntance.
  final _currentStory = ValueNotifier<Story?>(null);

  @override
  Widget build(BuildContext context) {
    return _StorybookInherited(
      state: this,
      child: ValueListenableBuilder<Story?>(
        valueListenable: _currentStory,
        builder: (context, value, __) {
          return ValueListenableBuilder(
            valueListenable: _knobStore,
            builder: (context, knobStore, __) {
              return widget.builder(context);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _knobStore.dispose();
    _currentStory.dispose();

    super.dispose();
  }
}
