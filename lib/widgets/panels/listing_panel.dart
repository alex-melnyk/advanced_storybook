import 'package:advanced_storybook/models/models.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Listing panel widget represents left side panel with sotries.
class ListingPannel extends StatelessWidget {
  ListingPannel({
    Key? key,
    required List<Story> stories,
    required this.controller,
  })  : stories = stories.groupListsBy((e) => e.section),
        super(key: key);

  late final Map<String, List<Story>> stories;
  final ValueNotifier<Story?> controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 300,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          right: Divider.createBorderSide(context),
        ),
      ),
      child: GestureDetector(
        onTap: () => controller.value = null,
        child: SingleChildScrollView(
          child: ValueListenableBuilder<Story?>(
            valueListenable: controller,
            builder: (_, selectedStory, __) {
              final storyPath = selectedStory?.key;

              return ExpansionPanelList(
                elevation: 0,
                expansionCallback: (panelIndex, isExpanded) {},
                children: List.generate(stories.entries.length, (index) {
                  final group = stories.entries.elementAt(index);

                  return ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      final sectionName =
                          group.key.isEmpty ? 'Ungrouped' : group.key;

                      return ListTile(
                        title: Text(sectionName),
                      );
                    },
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(group.value.length, (index) {
                        final story = group.value.elementAt(index);

                        return ListTile(
                          title: Text(story.title),
                          subtitle: story.description != null
                              ? Text(story.description!)
                              : null,
                          onTap: () => controller.value = story,
                          selected: story.key == storyPath,
                        );
                      }),
                    ),
                    isExpanded: true,
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
