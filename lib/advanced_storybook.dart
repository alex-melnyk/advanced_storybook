import 'package:advanced_storybook/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

export 'package:advanced_storybook/models/models.dart';

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
  final _selectedStory = ValueNotifier<int?>(null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 300,
          decoration: BoxDecoration(
            border: Border(
              right: Divider.createBorderSide(context),
            ),
          ),
          child: SingleChildScrollView(
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {},
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return ListTile(
                      title: Text('Stories'),
                    );
                  },
                  body: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.stories.length, (index) {
                      final story = widget.stories.elementAt(index);
                      return ListTile(
                        title: Text(story.name),
                        subtitle: story.description != null
                            ? Text(story.description!)
                            : null,
                        onTap: () {
                          _selectedStory.value = index;
                        },
                      );
                    }),
                  ),
                  isExpanded: true,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<int?>(
            valueListenable: _selectedStory,
            builder: (_, value, __) {
              if (value is int) {
                return Center(
                  child: Builder(
                    builder: widget.stories.elementAt(value).builder,
                  ),
                );
              }

              return const Placeholder(
                fallbackWidth: 100,
                fallbackHeight: 100,
              );
            },
          ),
        ),
      ],
    );
  }
}
