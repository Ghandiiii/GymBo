import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class VideoPlayerCustum extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerCustum( this.videoUrl,  {Key? key}) : super(key: key);


  @override
  _VideoPlayerCustumState createState() => _VideoPlayerCustumState();
}

class _VideoPlayerCustumState extends State<VideoPlayerCustum> {
  late String value;
  late VideoPlayerController _controller;
  late Future<void> _video;




  @override
  void initState() {
    super.initState();
    value = widget.videoUrl;
    _controller = VideoPlayerController.network(value);
    _video = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("see your target"),
        backgroundColor: Colors.black,
      ),
      body:
      FutureBuilder(
        future: _video,
        builder: (context,snapshot)
        {
          if(snapshot.connectionState == ConnectionState.done)
            {
              return AspectRatio(aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              );
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(_controller.value.isPlaying)
          {
            setState(() {
              _controller.pause();
            });
          }
        else{
          setState(() {
            _controller.play();
          });
        }
      },
        child:
        Icon(_controller.value.isPlaying ? Icons.pause:Icons.play_arrow),
      ),
    );
  }
}

