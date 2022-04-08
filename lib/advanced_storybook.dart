import 'package:advanced_storybook/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

export 'package:advanced_storybook/models/models.dart';

class AdvancedStorybook extends StatefulWidget {
  const AdvancedStorybook({
    Key? key,
    required this.stories,
  }) : super(key: key);

  final List<Story> stories;

  @override
  _AdvancedStorybookState createState() => _AdvancedStorybookState();
}

class _AdvancedStorybookState extends State<AdvancedStorybook> {
  late final ValueNotifier<Widget?> _selectedStory;

  @override
  void initState() {
    super.initState();

    _selectedStory = ValueNotifier<Widget?>(widget.stories.first.widgets.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Widget?>(
        valueListenable: _selectedStory,
        builder: (_, value, __) {
          if (value is Widget) {
            return Center(
              child: value,
            );
          }

          return const Placeholder(
            fallbackWidth: 100,
            fallbackHeight: 100,
          );
        },
      ),
    );
  }
}
