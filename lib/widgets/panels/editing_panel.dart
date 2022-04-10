import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class EditingPannel extends StatelessWidget {
  const EditingPannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    final knobStore = knobsProvider.knobStore;
    final story = storyProvider.story;

    final groups =
        knobStore.storyKnobs(story.key).values.groupListsBy((e) => e.section);

    return Container(
      width: 300,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          left: Divider.createBorderSide(context),
        ),
      ),
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          elevation: 0,
          expansionCallback: (panelIndex, isExpanded) {},
          children: [
            for (final group in groups.entries)
              ExpansionPanel(
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
                    final knobNode = group.value.elementAt(index);

                    if (knobNode is KnobNodeText) {
                      return KnobTextWidget(
                        knobNode: knobNode,
                      );
                    } else if (knobNode is KnobNodeOptions) {
                      return KnobOptionsWidget(
                        knobNode: knobNode,
                      );
                    } else if (knobNode is KnobNodeNumber) {
                      return KnobSliderWidget(
                        knobNode: knobNode,
                      );
                    } else if (knobNode is KnobNodeBool) {
                      return KnobCheckboxWidget(
                        knobNode: knobNode,
                      );
                    }

                    return Text('Unrecognized KNOB [${knobNode.key}]');
                  }),
                ),
                isExpanded: true,
              ),
          ],
        ),
      ),
    );
  }
}
