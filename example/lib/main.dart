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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: AdvancedStorybook(
          stories: [
            Story(
              key: 'Pages/Counter',
              description: 'Simple counter page',
              builder: (context) {
                return Material(
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text('App Bar'),
                      backgroundColor: context.options(
                        key: 'AppBar color',
                        description: 'Select the AppBar color',
                        options: [
                          Option(value: Colors.red),
                          Option(value: Colors.green),
                          Option(value: Colors.blue),
                        ],
                        initialIndex: 1,
                      ),
                    ),
                    body: ListView.builder(
                      itemCount: context.number(
                        key: 'ListTile amount',
                        description: 'Configure amount of list tiles.',
                        initial: 5,
                        min: 0,
                        max: 50,
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(context.string(
                            key: 'ListTile title',
                            initial: 'ListTile Item',
                          )),
                          subtitle: Text(context.string(
                            key: 'ListTile subtitle',
                            initial: 'Dynamicaly generated items',
                          )),
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
              key: 'Common/ElevatedButton 1',
              description: 'Story for ElevatedButton 1',
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
