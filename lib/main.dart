//import 'package:chewie_prep/chewie_list_item.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter_app/chewie_list_item.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

Future<Album> fetchAlbum() async {
  final response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({@required this.userId, @required this.id, @required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(cameras),
    );
  }
}

class DrawerOnly extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Drawer(
        child: new ListView(
      children: <Widget>[
        Container(
          height: 55.0,
          child: DrawerHeader(
              child: Text('Categories',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
              decoration: BoxDecoration(color: Colors.blue),
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0)),
        ),
        new ListTile(
            title: new Text("Home"),
            leading: Icon(Icons.home),
            //tileColor: Colors.cyan,
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pop(ctxt);
              Navigator.push(
                  ctxt,
                  new MaterialPageRoute<void>(
                      builder: (ctxt) => new MyHomePage(cameras)));
            },
            selectedTileColor: Colors.amber),
        new ListTile(
          title: new Text("Settings"),
          leading: Icon(Icons.settings),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(
                ctxt,
                new MaterialPageRoute<void>(
                    builder: (ctxt) => new SettingsPage()));
          },
        ),
        new ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://motorblock.at/wp-content/uploads/2018/09/Tom-der-Abschleppwagen.jpg'),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: new Text("Puksiirauto Tom"),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(
                ctxt,
                new MaterialPageRoute<void>(
                    builder: (ctxt) => new SecondPage()));
          },
        ),
        new ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://specials-images.forbesimg.com/imageserve/5fd7928e1f37990503a26dbb/960x0.jpg?fit=scale'),
          ),
          title: new Text("CoComelon Baby"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(
                ctxt,
                new MaterialPageRoute<void>(
                    builder: (ctxt) => new CoComelonBabyPage()));
          },
        ),
        new ListTile(
          title: new Text("Data from Internet"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pop(ctxt);
            Navigator.push(
                ctxt,
                new MaterialPageRoute<void>(
                    builder: (ctxt) => new FetchdataPage()));
          },
        ),
      ],
    ));
  }
}

class MyHomePage extends StatefulWidget {
  List<CameraDescription> cameras;

  MyHomePage(this.cameras);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  Widget build(BuildContext ctxt) {
    return Scaffold(
      drawer: new DrawerOnly(),
      appBar: AppBar(
        title: Text('Home'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.camera_alt)),
          ],
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          VideoItemList(),
          LandingScreen(),
          //CameraScreen(widget.cameras),
        ],
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File imageFile;
  File videoFile;

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    var video = await ImagePicker().getVideo(source: ImageSource.gallery);

    this.setState(() {
      imageFile = File(picture.path);
      videoFile = File(video.path);
    });

    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
    });
    GallerySaver.saveImage(picture.path);
    Navigator.of(context).pop();
  }

  void _recordVideo(BuildContext context) async {
    // ignore: deprecated_member_use
    var video = await ImagePicker().getVideo(source: ImageSource.gallery);
    this.setState(() {
      videoFile = File(video.path);
    });
    GallerySaver.saveVideo(video.path);
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Video"),
                    onTap: () {
                      _recordVideo(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text("No image selected");
    } else {
      return Image.file(imageFile, width: 200, height: 200);
    }
  }

  Widget _decideVideoView() {
    if (videoFile == null) {
      return Text("No video selected");
    } else {
      return ChewieListItem(
          videoPlayerController: VideoPlayerController.file(videoFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              _decideVideoView(),
              RaisedButton(
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Select Image"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VideoItemList extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
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

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      drawer: new DrawerOnly(),
      appBar: AppBar(
        title: Text('Puksiirauto Tom'),
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

class CoComelonBabyPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      drawer: new DrawerOnly(),
      appBar: AppBar(
        title: Text('CoComelonBaby'),
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

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    this.readFile();
    return new Scaffold(
      drawer: new DrawerOnly(),
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: (text) {
              this.saveFile(text);
            },
          ),
        ],
      ),
    );
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/appSettings.txt'; // 3

    return filePath;
  }

  void saveFile(String txt) async {
    File file = File(await getFilePath()); // 1
    file.writeAsString(txt); // 2
  }

  void readFile() async {
    File file = File(await getFilePath()); // 1
    String fileContent = await file.readAsString(); // 2

    print('File Content: $fileContent');
  }
}

class FetchdataPage extends StatefulWidget {
  FetchdataPage({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FetchdataPage> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
