import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:advanced_storybook/models/models.dart';
import 'package:advanced_storybook/providers/story_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Single story viewer widget.
class StoryViewer extends StatefulWidget {
  const StoryViewer({
    Key? key,
    required this.story,
    this.onPressedSettings,
  }) : super(key: key);

  /// Story instance to view.
  final Story? story;

  final VoidCallback? onPressedSettings;

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  final _repaintBoundary = GlobalKey();
  final _screenshotVisibility = ValueNotifier<bool>(false);
  final _screenshotData = ValueNotifier<Uint8List?>(null);
  Timer? _screenshotTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            DevicePreview(
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

                return const Center(
                  child: Text('Select a story to preview'),
                );
              },
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
                        ? Alignment.bottomRight
                        : const Alignment(2.0, 1.0),
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Column(
          children: [
            if (widget.story != null)
              FloatingActionButton(
                onPressed: _handleTakeScreenshot,
                child: const Icon(Icons.screenshot),
              ),
            if (widget.onPressedSettings != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                ),
                child: FloatingActionButton(
                  onPressed: widget.onPressedSettings,
                  child: const Icon(Icons.settings),
                ),
              ),
          ],
        ));
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
}
