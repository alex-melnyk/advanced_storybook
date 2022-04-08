import 'package:advanced_storybook/models/models.dart';
import 'package:flutter/material.dart';

class EditingPannel extends StatelessWidget {
  const EditingPannel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ValueNotifier<Story?> controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
}
