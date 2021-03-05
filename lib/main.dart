//import 'package:chewie_prep/chewie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'chewie_list_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: ListView(
        children: <Widget>[
         /* ChewieListItem(
            videoPlayerController: VideoPlayerController.asset(
              'videos/BabyShark.mp4',
            ),
            looping: true,
          ),*/
          ChewieListItem(
            videoPlayerController: VideoPlayerController.network(
              'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4',
            ),
          ),
          ChewieListItem(
            videoPlayerController: VideoPlayerController.network(
              'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4',
            ),
          ),
        ],
      ),
    );
  }
}




