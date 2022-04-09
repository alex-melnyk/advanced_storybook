import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

export 'package:advanced_storybook/models/models.dart';
export 'package:advanced_storybook/widgets/widgets.dart';

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
  final _currentStory = ValueNotifier<Story?>(null);

  @override
  Widget build(BuildContext context) {
    return KnobsProvider(
      child: ValueListenableBuilder<Story?>(
        valueListenable: _currentStory,
        builder: (context, selectedStory, child) {
          return Stack(
            children: [
              if (selectedStory is Story)
                Center(
                  child: StoryProvider(
                    story: selectedStory,
                    child: Builder(
                      builder: selectedStory.builder,
                    ),
                  ),
                )
              else
                const Placeholder(
                  fallbackWidth: 100,
                  fallbackHeight: 100,
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: StoriesPannel(
                  stories: widget.stories,
                  controller: _currentStory,
                ),
              ),
              ValueListenableBuilder<Story?>(
                valueListenable: _currentStory,
                builder: (_, value, __) {
                  return AnimatedAlign(
                    alignment: value == null
                        ? const Alignment(2.0, 0.0)
                        : Alignment.centerRight,
                    duration: const Duration(milliseconds: 200),
                    child: value != null
                        ? EditingPannel(
                            story: value,
                          )
                        : const SizedBox(),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
