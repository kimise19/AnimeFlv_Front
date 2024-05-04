import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  double _progressValue = 0.0;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(_onVideoPlayerListener);
    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _controller.play();
          _showControls = true;
          _startHideControlsTimer();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoPlayerListener);
    _controller.dispose();
    super.dispose();
  }

  void _onVideoPlayerListener() {
    if (mounted) {
      setState(() {
        _progressValue = _controller.value.position.inMilliseconds /
            _controller.value.duration.inMilliseconds;
        if (_controller.value.isInitialized &&
            _controller.value.isPlaying &&
            !_controller.value.isBuffering &&
            _controller.value.duration == _controller.value.position) {
          _showControls = false;
        }
      });
    }
  }

  void _startHideControlsTimer() {
    Future.delayed(const Duration(seconds: 7), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
            if (_showControls) {
              _startHideControlsTimer();
            }
          });
        },
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              if (_showControls)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (mounted) {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: Icon(Icons.close_sharp, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            if (mounted) {
                              _controller.seekTo(Duration(
                                  milliseconds: (_controller
                                              .value.position.inMilliseconds -
                                          10000)
                                      .toInt()));
                            }
                          },
                          icon: Icon(Icons.replay_10, color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            if (mounted) {
                              setState(() {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                              });
                            }
                          },
                          icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 40),
                        ),
                        IconButton(
                          onPressed: () {
                            if (mounted) {
                              _controller.seekTo(Duration(
                                  milliseconds: (_controller
                                              .value.position.inMilliseconds +
                                          10000)
                                      .toInt()));
                            }
                          },
                          icon: Icon(Icons.forward_10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              if (_showControls)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 60,
                  child: Slider(
                    value: _progressValue,
                    onChanged: (newValue) {
                      final newPosition =
                          newValue * _controller.value.duration.inMilliseconds;
                      if (mounted) {
                        _controller.seekTo(
                            Duration(milliseconds: newPosition.toInt()));
                      }
                    },
                    activeColor: Colors.orange,
                    inactiveColor: Colors.grey,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
