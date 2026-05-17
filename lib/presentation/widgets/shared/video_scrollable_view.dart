import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/shared/video_buttons.dart';
import 'package:toktik/presentation/widgets/video/fullscreen_player.dart';

class VideoScrollableView extends StatelessWidget {

  final List<VideoPost> videos;
  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: videos.length,
      // children:[ Container(color: Colors.red), Container(color: Colors.blue), Container(color: Colors.green)],
      itemBuilder: (context, index) {
        final VideoPost videoPost = videos[index];

        return Stack(
          children: [

          //video player +gradient
            // FullScreenPlayer(),
            SizedBox.expand(
              child: FullscreenPlayer(
                key: ValueKey(videoPost.videoUrl),
                caption: videoPost.caption,
                videoUrl: videoPost.videoUrl,
              ),
            ),
          //Bottom information
          Positioned(
            right: 20,
            bottom: 0,
            child: SafeArea(
              top: false,
              child: VideoButtons(video: videoPost),
            ),
          ),
          ]
        );  
      },
    );
  }
}