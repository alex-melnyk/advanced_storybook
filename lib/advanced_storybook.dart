import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
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
  final _selectedStory = ValueNotifier<Story?>(null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StoriesPannel(
          stories: widget.stories,
          controller: _selectedStory,
        ),
        Expanded(
          child: ValueListenableBuilder<Story?>(
            valueListenable: _selectedStory,
            builder: (_, value, __) {
              if (value is Story) {
                return Center(
                  child: Builder(
                    builder: value.builder,
                  ),
                );
              }

              return const Placeholder(
                fallbackWidth: 100,
                fallbackHeight: 100,
              );
            },
          ),
        ),
      ],
    );
  }
}
