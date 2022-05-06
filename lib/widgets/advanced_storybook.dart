import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdvancedStorybook extends StatefulWidget {
  const AdvancedStorybook({
    Key? key,
    required this.stories,
  }) : super(key: key);

  /// List of stories.
  final List<Story> stories;

  @override
  State<AdvancedStorybook> createState() => _AdvancedStorybookState();
}

class _AdvancedStorybookState extends State<AdvancedStorybook> {
  final _zoom = ValueNotifier<double>(1.0);

  @override
  Widget build(BuildContext context) {
    return StorybookProvider(
      stories: widget.stories,
      builder: (context) {
        final storybook = StorybookProvider.of(context);
        final isStorySelected = storybook.currentStory is Story;

        return Column(
          children: [
            ZoomPanel(
              controller: _zoom,
            ),
            Expanded(
              child: Stack(
                children: [
                  StoryViewer(
                    story: storybook.currentStory,
                    zoomController: _zoom,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ListingPannel(
                      stories: widget.stories,
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
              ),
            ),
          ],
        );
      },
    );
  }
}
