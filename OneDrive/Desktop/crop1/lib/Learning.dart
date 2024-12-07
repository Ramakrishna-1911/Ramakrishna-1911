import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final _picker = ImagePicker();
  File? _videoFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userId;

  @override
  void initState() {
    super.initState();
    // Get the current user ID for uploading metadata (this assumes the user is logged in)
    _userId = _auth.currentUser?.uid;
  }

  // Method to pick video from gallery or camera
  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _videoFile = File(video.path);
      });
    }
  }

  // Method to upload video to Firebase Storage
  Future<void> _uploadVideo() async {
    if (_videoFile == null) {
      Fluttertoast.showToast(msg: "Please select a video.");
      return;
    }

    try {
      // Get the file name
      String fileName = basename(_videoFile!.path);
      Reference reference = FirebaseStorage.instance.ref().child('videos/$fileName');
      UploadTask uploadTask = reference.putFile(_videoFile!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      // Get the video URL
      String videoUrl = await taskSnapshot.ref.getDownloadURL();

      // Save metadata (video URL, user ID) in Firestore
      await FirebaseFirestore.instance.collection('videos').add({
        'url': videoUrl,
        'uploadedBy': _userId,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Fluttertoast.showToast(msg: "Video uploaded successfully.");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error uploading video: $e");
    }
  }

  // Method to fetch and display videos from Firestore
  Stream<QuerySnapshot> _fetchVideos() {
    return FirebaseFirestore.instance
        .collection('videos')
        .orderBy('timestamp', descending: true)  // Show latest videos first
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload & View Videos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload Section
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickVideo,
                  child: Text("Select Video"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _uploadVideo,
                  child: Text("Upload Video"),
                ),
              ],
            ),
            // Displaying selected video (if any)
            if (_videoFile != null) ...[
              SizedBox(height: 20),
              Text("Selected Video:"),
              Container(
                height: 200,
                width: double.infinity,
                child: VideoPlayerWidget(videoFile: _videoFile!),  // Display the video
              ),
            ],
            SizedBox(height: 20),
            // Displaying uploaded videos
            Text("Uploaded Videos:"),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _fetchVideos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No videos uploaded.'));
                  }

                  final videos = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final videoUrl = videos[index]['url'];
                      return Card(
                        child: ListTile(
                          title: Text("Video ${index + 1}"),
                          subtitle: Text("Uploaded by: ${videos[index]['uploadedBy']}"),
                          trailing: IconButton(
                            icon: Icon(Icons.play_arrow),
                            onPressed: () {
                              // Handle video play (navigate to full screen or play in a widget)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlayerPage(url: videoUrl),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget to play a video using the VideoPlayerController
class VideoPlayerPage extends StatefulWidget {
  final String url;
  VideoPlayerPage({required this.url});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});  // Ensure the widget is updated when the video is initialized
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
      appBar: AppBar(title: Text("Video Player")),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
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

class VideoPlayerWidget extends StatelessWidget {
  final File videoFile;
  VideoPlayerWidget({required this.videoFile});

  @override
  Widget build(BuildContext context) {
    // You can add similar functionality for local video files if needed using the video_player package.
    return Text("Video display goes here");
  }
}