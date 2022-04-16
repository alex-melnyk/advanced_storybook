import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdvancedStorybook extends StatelessWidget {
  const AdvancedStorybook({
    Key? key,
    required this.stories,
  }) : super(key: key);

  /// List of stories.
  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return StorybookProvider(
      stories: stories,
      builder: (context) {
        final storybook = StorybookProvider.of(context);
        final isStorySelected = storybook.currentStory is Story;

        return Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 300,
                ),
                child: StoryViewer(
                  story: storybook.currentStory,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ListingPannel(
                stories: stories,
              ),
            ),
            AnimatedAlign(
              alignment: isStorySelected
                  ? Alignment.centerRight
                  : const Alignment(2.0, 0.0),
              duration: const Duration(milliseconds: 200),
              child: EditingPannel(
                story: storybook.currentStory,
              ),
            ),
          ],
        );
      },
    );
  }
}
