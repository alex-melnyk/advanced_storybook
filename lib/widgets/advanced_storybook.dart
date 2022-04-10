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

  final List<Story> stories;

  @override
  _AdvancedStorybookState createState() => _AdvancedStorybookState();
}

class _AdvancedStorybookState extends State<AdvancedStorybook> {
  final _knobStore = KnobStore();
  final _currentStory = ValueNotifier<Story?>(null);

  @override
  void didUpdateWidget(covariant AdvancedStorybook oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.stories != widget.stories && _currentStory.value != null) {
      _currentStory.value = null;
      _knobStore.clearValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Story?>(
      valueListenable: _currentStory,
      builder: (_, currentStory, __) {
        return ValueListenableBuilder(
          valueListenable: _knobStore,
          builder: (context, value, __) {
            return KnobsProvider(
              knobStore: _knobStore,
              child: Stack(
                children: [
                  if (currentStory is Story)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 300,
                        ),
                        child: StoryViewer(
                          story: currentStory,
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
                    child: ListingPannel(
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
                            ? StoryProvider(
                                story: value,
                                child: const EditingPannel(),
                              )
                            : const SizedBox(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _currentStory.dispose();
    _knobStore.dispose();

    super.dispose();
  }
}
