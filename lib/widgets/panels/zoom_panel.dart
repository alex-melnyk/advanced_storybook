import 'package:flutter/material.dart';

class ZoomPanel extends StatelessWidget {
  const ZoomPanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ValueNotifier<double> controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(
          bottom: Divider.createBorderSide(context),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => controller.value -= 0.05,
            icon: const Icon(Icons.zoom_out),
          ),
          ValueListenableBuilder<double>(
            valueListenable: controller,
            builder: (context, value, __) {
              final percentage = value * 100;

              return Text(percentage.toStringAsFixed(2));
            },
          ),
          IconButton(
            onPressed: () => controller.value += 0.05,
            icon: const Icon(Icons.zoom_in),
          ),
        ],
      ),
    );
  }
}
