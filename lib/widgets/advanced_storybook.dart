import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:advanced_storybook/widgets/adaptive_layout.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
  final _settingsKey = GlobalKey<ScaffoldState>();
  final _showSettings = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return StorybookProvider(
      stories: widget.stories,
      builder: (context) {
        final storybook = StorybookProvider.of(context);
        final isStorySelected = storybook.currentStory is Story;

        return ValueListenableBuilder<bool>(
          valueListenable: _showSettings,
          builder: (_, showSettings, __) {
            return AdaptiveLayout(
              mobile: Scaffold(
                key: _settingsKey,
                drawer: showSettings
                    ? EditingPannel(
                        story: storybook.currentStory,
                        onPressedBack: _updateShowSettings,
                      )
                    : ListingPannel(
                        stories: widget.stories,
                        onPressedBack: _updateShowSettings,
                      ),
                body: StoryViewer(
                  story: storybook.currentStory,
                  onPressedSettings: () =>
                      _settingsKey.currentState?.openDrawer(),
                ),
              ),
              tablet: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(
                      left: 300,
                    ),
                    child: StoryViewer(
                      story: storybook.currentStory,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ListingPannel(
                      stories: widget.stories,
                      onPressedBack: _updateShowSettings,
                    ),
                  ),
                  if (showSettings)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: EditingPannel(
                        story: storybook.currentStory,
                        onPressedBack: _updateShowSettings,
                      ),
                    ),
                ],
              ),
              desktop: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 300,
                    ),
                    child: StoryViewer(
                      story: storybook.currentStory,
                    ),
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
                        : const Alignment(
                            2.0,
                            0.0,
                          ),
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    child: EditingPannel(
                      story: storybook.currentStory,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _updateShowSettings() {
    _showSettings.value = !_showSettings.value;
  }
}
