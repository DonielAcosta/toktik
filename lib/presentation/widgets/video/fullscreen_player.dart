import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullscreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;
  const FullscreenPlayer({
    super.key,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<FullscreenPlayer> createState() => _FullscreenPlayerState();
}

class _FullscreenPlayerState extends State<FullscreenPlayer> {
  late VideoPlayerController controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.videoUrl);

    controller.initialize().then((_) {
      if (!mounted) return;
      controller
        ..setVolume(0)
        ..setLooping(true)
        ..play();
      setState(() {});
    }).catchError((_) {
      if (!mounted) return;
      setState(() => _hasError = true);
    });
  }

  @override
  void dispose() {
    controller.pause();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Icon(Icons.error_outline, color: Colors.white, size: 40),
      );
    }

    if (!controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return GestureDetector(
      onTap: () {
        if (controller.value.isPlaying) {
          controller.pause();
          return;
        }
        controller.play();
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          ),
          VideoBackground(stops: const [0.8, 1.0]),
          Positioned(
            left: 20,
            right: 80,
            bottom: 0,
            child: SafeArea(
              top: false,
              minimum: const EdgeInsets.only(bottom: 12),
              child: _VideoCaption(caption: widget.caption),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;
  const _VideoCaption({required this.caption});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: Colors.white,
      shadows: const [
        Shadow(blurRadius: 8, color: Colors.black54),
      ],
    );
    return Text(
      caption,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: titleStyle,
    );
  }
}
