import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Stateful widget to fetch and then display video content.
class VideoPage extends StatefulWidget {
  const VideoPage({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  final _formKey = GlobalKey<FormState>();
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String ctime = DateFormat("HH:mm:ss").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('${widget.url}')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference Upload =
        FirebaseFirestore.instance.collection('Upload');

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Center(
          child: Container(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Upload.add({
            //   'Date': '20023',
            //   'Name': '1234',
            //   'Question': '1234',
            //   'Time': '23412'
            // })
            //     .then((value) => print("User Added"))
            //     .catchError((error) => print("Failed to add user: $error"));
            // Upload
            //   ..get().then((QuerySnapshot querySnapshot) {
            //     querySnapshot.docs.forEach((doc) {
            //       print(doc['Date']);
            //     });
            //   });
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
