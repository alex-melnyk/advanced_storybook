import 'package:advanced_storybook/models/models.dart';
import 'package:flutter/widgets.dart';

class StoryProvider extends InheritedWidget {
  const StoryProvider({
    Key? key,
    required this.story,
    required Widget child,
  }) : super(key: key, child: child);

  final Story story;

  static StoryProvider of(BuildContext context) {
    final StoryProvider? result =
        context.dependOnInheritedWidgetOfExactType<StoryProvider>();
    assert(result != null, 'No StoryProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(StoryProvider oldWidget) {
    return oldWidget.story != story;
  }
}
