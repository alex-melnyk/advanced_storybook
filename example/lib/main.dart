import 'package:advanced_storybook/advanced_storybook.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AdvancedStorybook(
          stories: [
            Story(
              key: 'Pages/Counter',
              description: 'Simple counter page',
              builder: (context) {
                return Material(
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(context.string(
                        key: 'AppBar/Title',
                        initial: 'App Bar',
                      )),
                      backgroundColor: context.options(
                        key: 'AppBar/Background color',
                        description: 'Select the AppBar color',
                        options: [
                          for (final color in Colors.primaries)
                            Option(value: color),
                        ],
                        initialIndex: 0,
                      ),
                    ),
                    body: ListView.builder(
                      itemCount: context.number(
                        key: 'ListTile/Items amount',
                        description: 'Configure amount of list tiles.',
                        initial: 5,
                        min: 0,
                        max: 50,
                      ),
                      itemBuilder: (context, index) {
                        final title = context.string(
                          key: 'ListTile/Items title',
                          description: 'Common items title',
                          initial: 'ListTile Item',
                        );
                        final subtitle = context.string(
                          key: 'ListTile/Items subtitle',
                          description: 'Common items subtitle',
                          initial: 'Dynamicaly generated items',
                        );

                        return ListTile(
                          title: Text('$title $index'),
                          subtitle: Text(subtitle),
                        );
                      },
                    ),
                    floatingActionButton: context.boolean(
                      key: 'FAB enabled',
                      initial: true,
                    )
                        ? FloatingActionButton(
                            onPressed: () {},
                            child: const Icon(Icons.all_inbox),
                          )
                        : null,
                  ),
                );
              },
            ),
            Story(
              key: 'Common/Hello Knob Button',
              description: 'Hello Knob Button',
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {},
                  child: Text(context.string(
                    key: 'firstKnob',
                    description: 'Simple description',
                    initial: 'Hello KNOB',
                  )),
                );
              },
            ),
            Story(
              key: 'Common/ElevatedButton 2',
              description: 'Story for ElevatedButton 2',
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'ElevatedButton 2',
                  ),
                );
              },
            ),
            Story(
              key: 'TextField',
              description: 'Simple story for TextField',
              builder: (context) {
                return SizedBox(
                  width: 300,
                  child: TextField(
                    controller: TextEditingController(text: 'Hello Storybook'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
