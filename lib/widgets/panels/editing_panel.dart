import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// Editing panel widget represents right side panel with knobs.
class EditingPannel extends StatefulWidget {
  const EditingPannel({
    Key? key,
    this.isExpanded = true,
    this.story,
  }) : super(key: key);

  final bool isExpanded;
  final Story? story;

  @override
  State<EditingPannel> createState() => _EditingPannelState();
}

class _EditingPannelState extends State<EditingPannel> {
  final _expansions = <int, bool>{};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.story == null) {
      return Container(
        width: 300,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border(
            left: Divider.createBorderSide(context),
          ),
        ),
      );
    }

    final storybookProvider = StorybookProvider.of(context);
    final knobStore = storybookProvider.knobStore;

    final groups = knobStore
        .storyKnobs(widget.story!.key)
        .values
        .groupListsBy((e) => e.section);

    return Container(
      width: 300,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          left: Divider.createBorderSide(context),
        ),
      ),
      child: Builder(
        builder: (context) {
          if (groups.isEmpty) {
            return const Center(
              child: Text('No KNOBS'),
            );
          }

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ExpansionPanelList(
              key: ValueKey(widget.story!.key),
              elevation: 1,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _expansions[panelIndex] = !isExpanded;
                });
              },
              children: List.generate(
                groups.length,
                (panelIndex) {
                  final group = groups.entries.elementAt(panelIndex);

                  return ExpansionPanel(
                    isExpanded: _expansions[panelIndex] ?? widget.isExpanded,
                    canTapOnHeader: false,
                    headerBuilder: (context, isExpanded) {
                      final sectionName =
                          group.key.isEmpty ? 'Ungrouped' : group.key;

                      return ListTile(
                        title: Text(sectionName),
                      );
                    },
                    body: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final knobNode in group.value)
                          if (knobNode is KnobNodeText)
                            KnobTextWidget(
                              key: ValueKey(knobNode.key),
                              knobNode: knobNode,
                            )
                          else if (knobNode is KnobNodeOptions)
                            KnobOptionsWidget(
                              key: ValueKey(knobNode.key),
                              knobNode: knobNode,
                            )
                          else if (knobNode is KnobNodeNumber)
                            KnobSliderWidget(
                              key: ValueKey(knobNode.key),
                              knobNode: knobNode,
                            )
                          else if (knobNode is KnobNodeBool)
                            KnobCheckboxWidget(
                              key: ValueKey(knobNode.key),
                              knobNode: knobNode,
                            )
                          else
                            Text('Unrecognized KNOB [${knobNode.key}]'),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  const HeaderDelegate({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
      ),
      child: child,
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant HeaderDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
