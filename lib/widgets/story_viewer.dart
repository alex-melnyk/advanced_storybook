import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/providers/providers.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

class StoryViewer extends StatelessWidget {
  const StoryViewer({
    Key? key,
    required this.story,
  }) : super(key: key);

  final Story story;

  @override
  Widget build(BuildContext context) {
    return StoryProvider(
      story: story,
      child: DevicePreview(
        builder: (context) {
          return Center(
              child: Builder(builder: story.builder,),
          );
        },
      ),
    );
  }
}
