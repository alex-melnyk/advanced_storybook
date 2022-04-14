import 'package:advanced_storybook/models/models.dart';
import 'package:flutter/widgets.dart';

/// Single [Story] instance provider.
class StoryProvider extends InheritedWidget {
  const StoryProvider({
    Key? key,
    required this.story,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  /// [Story] instance.
  final Story story;

  /// Gets [StoryProvider] from context.
  static StoryProvider of(BuildContext context) {
    final StoryProvider? result =
        context.dependOnInheritedWidgetOfExactType<StoryProvider>();
    assert(result != null, 'No StoryProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(StoryProvider oldWidget) {
    return true;
  }
}
