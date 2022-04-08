import 'package:flutter/widgets.dart';

class Story {
  const Story({
    required this.name,
    this.description,
    required this.builder,
  });

  final String name;
  final String? description;
  final WidgetBuilder builder;
}
