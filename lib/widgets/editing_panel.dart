import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditingPannel extends StatefulWidget {
  const EditingPannel({
    Key? key,
  }) : super(key: key);

  @override
  State<EditingPannel> createState() => _EditingPannelState();
}

class _EditingPannelState extends State<EditingPannel> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final knobsProvider = KnobsProvider.of(context);
    final storyProvider = StoryProvider.of(context);

    final knobStore = knobsProvider.knobStore;
    final story = storyProvider.story;

    final props = knobStore.storyKnobs(story.key);

    return Container(
      width: 300,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          left: Divider.createBorderSide(context),
        ),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        itemCount: props.length,
        itemBuilder: (context, index) {
          final knobNode = props.values.elementAt(index);

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
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
