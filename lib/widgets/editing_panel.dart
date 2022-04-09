import 'package:advanced_storybook/knobs/knobs.dart';
import 'package:advanced_storybook/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditingPannel extends StatefulWidget {
  const EditingPannel({
    Key? key,
    required this.story,
  }) : super(key: key);

  final Story story;

  @override
  State<EditingPannel> createState() => _EditingPannelState();
}

class _EditingPannelState extends State<EditingPannel> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final knobsProvider = KnobsProvider.of(context);
    final knobStore = knobsProvider.knobStore;
    final props = knobStore.storyKnobs(widget.story.key);

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
        child: Column(
          children: List.generate(props.entries.length, (index) {
            final knobValue = props.values.elementAt(index);

            if (knobValue is KnobNodeText) {
              return ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                    isDense: false,
                    labelText: knobValue.key,
                    border: const OutlineInputBorder(),
                  ),
                  initialValue: knobValue.value,
                  onChanged: (value) {
                    knobStore.updateStoryKnobValue(
                      widget.story.key,
                      knobKey: knobValue.key,
                      newValue: value,
                    );
                  },
                ),
                subtitle: knobValue.description != null
                    ? Text(knobValue.description!)
                    : null,
              );
            } else if (knobValue is KnobOptionsNode) {
              return ListTile(
                title: DropdownButtonFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: knobValue.key,
                    border: const OutlineInputBorder(),
                  ),
                  value: knobValue.value,
                  items: [
                    for (final e in knobValue.options)
                      if (e.value is Color)
                        DropdownMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                margin: const EdgeInsets.only(
                                  right: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: e.value,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Text(
                                e.toString(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      else
                        DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                  ],
                  onChanged: (value) {
                    knobStore.updateStoryKnobValue(
                      widget.story.key,
                      knobKey: knobValue.key,
                      newValue: value,
                    );
                  },
                ),
                subtitle: knobValue.description != null
                    ? Text(knobValue.description!)
                    : null,
              );
            }

            return const Text('Unrecognized KNOB');
          }),
        ),
      ),
    );
  }
}
