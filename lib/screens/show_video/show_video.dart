import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screw_calc/components/custom_text.dart';
import 'package:screw_calc/utility/app_theme.dart';
import 'package:video_player/video_player.dart';

class ShowVideo extends StatefulWidget {
  const ShowVideo({super.key});

  @override
  State<ShowVideo> createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  late VideoPlayerController _controller;
  double _volume = 1.0; // Default volume (1.0 is max)

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/screw_video.mp4')
      ..initialize().then((ee) {
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.grayy,
        title: CustomText(text: "شرح قواعد اللعبة", fontSize: 22.sp),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Transform.flip(
                flipX: true,
                child: const Icon(
                  Icons.arrow_back_ios_sharp,
                  color: AppColors.white,
                ),
              ))
        ],
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  const SizedBox(height: 20),
                  // Volume Control
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.volume_down,
                        color: AppColors.white,
                      ),
                      Slider(
                        value: _volume,
                        min: 0.0,
                        max: 1.0,
                        divisions: 10,
                        label: (_volume * 100).toInt().toString(),
                        onChanged: (value) {
                          setState(() {
                            _volume = value;
                            _controller.setVolume(_volume);
                          });
                        },
                      ),
                      const Icon(
                        Icons.volume_up,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ],
              )
            : const CircularProgressIndicator(), // Show a loader until the video is initialized
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
