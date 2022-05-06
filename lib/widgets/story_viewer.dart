import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/providers/story_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// Single story viewer widget.
class StoryViewer extends StatefulWidget {
  const StoryViewer({
    Key? key,
    required this.story,
    this.zoomController,
  }) : super(key: key);

  /// Story instance to view.
  final Story? story;
  final ValueNotifier<double>? zoomController;

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  final _repaintBoundary = GlobalKey();
  final _screenshotVisibility = ValueNotifier<bool>(false);
  final _screenshotData = ValueNotifier<Uint8List?>(null);
  final _offsetController = ValueNotifier<Offset>(Offset.zero);
  late final ValueNotifier<double> _zoomController;
  bool isMetaPressed = false;
  Timer? _screenshotTimer;
  final focudNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _zoomController = widget.zoomController ?? ValueNotifier<double>(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        autofocus: true,
        focusNode: focudNode,
        skipTraversal: true,
        canRequestFocus: true,
        onKeyEvent: (node, event) {
          isMetaPressed = event.physicalKey == PhysicalKeyboardKey.metaLeft;

          return KeyEventResult.ignored;
        },
        child: GestureDetector(
          onPanStart: _handleDragStart,
          onPanUpdate: _handleDragUpdate,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  ValueListenableBuilder<Offset>(
                    valueListenable: _offsetController,
                    builder: (context, offset, child) {
                      return Positioned(
                        left: offset.dx,
                        top: offset.dy,
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: Center(
                          child: child!,
                        ),
                      );
                    },
                    child: ValueListenableBuilder<double>(
                      valueListenable: _zoomController,
                      builder: (context, zoom, __) {
                        return AnimatedScale(
                          duration: const Duration(milliseconds: 150),
                          scale: zoom,
                          alignment: Alignment.center,
                          child: DeviceFrame(
                            isFrameVisible: true,
                            device: Devices.ios.iPhone13Mini,
                            screen: Scaffold(
                              body: Builder(
                                builder: (context) {
                                  if (widget.story is Story) {
                                    final viewStory = widget.story as Story;
                                    return Center(
                                      child: RepaintBoundary(
                                        key: _repaintBoundary,
                                        child: StoryProvider(
                                          story: viewStory,
                                          child: Builder(
                                            builder: viewStory.builder,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return const Scaffold(
                                    body: Center(
                                      child: Text('Select a story to preview'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _screenshotVisibility,
                    builder: (context, visibility, child) {
                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: visibility ? 1.0 : 0.0,
                        child: AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          alignment: visibility
                              ? Alignment.bottomCenter
                              : const Alignment(1.0, 2.0),
                          child: child!,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            width: 200,
                            height: 200,
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 2,
                              ),
                            ),
                            child: ValueListenableBuilder<Uint8List?>(
                              valueListenable: _screenshotData,
                              builder: (context, data, __) {
                                if (data == null) {
                                  return const SizedBox();
                                }

                                return Image.memory(
                                  data,
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: widget.story != null
          ? FloatingActionButton(
              onPressed: _handleTakeScreenshot,
              child: const Icon(Icons.screenshot),
            )
          : null,
    );
  }

  void _handleDragStart(DragStartDetails details) {
    focudNode.requestFocus();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isMetaPressed) {
      _offsetController.value += details.delta;
    }
  }

  void _handleTakeScreenshot() async {
    final boundary = _repaintBoundary.currentContext!.findRenderObject()
        as RenderRepaintBoundary;

    final image = await boundary.toImage();
    final imageBytes = await image.toByteData(format: ImageByteFormat.png);
    _screenshotData.value = imageBytes!.buffer.asUint8List();
    _screenshotVisibility.value = true;

    _screenshotTimer?.cancel();
    _screenshotTimer = Timer(const Duration(seconds: 3), () {
      _screenshotVisibility.value = false;
    });
  }

  @override
  void dispose() {
    if (widget.zoomController == null) {
      _zoomController.dispose();
    }

    super.dispose();
  }
}
