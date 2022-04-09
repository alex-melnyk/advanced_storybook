import 'package:advanced_storybook/models/models.dart';
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
    final props = knobsProvider.knobsValuesFor(widget.story.path);

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

            return ListTile(
              title: ValueListenableBuilder<String>(
                valueListenable: knobValue,
                builder: (_, value, __) {
                  return TextFormField(
                    decoration: InputDecoration(
                      isDense: false,
                      labelText: knobValue.key,
                      border: const OutlineInputBorder(),
                    ),
                    initialValue: value,
                    onChanged: (text) {
                      knobValue.value = text;
                    },
                  );
                },
              ),
              subtitle: knobValue.description != null
                  ? Text(knobValue.description!)
                  : null,
            );
          }),
        ),
      ),
    );
  }
}
