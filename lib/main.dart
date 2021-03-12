//import 'package:chewie_prep/chewie_list_item.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'camera_screen.dart';
import 'chewie_list_item.dart';
import 'package:camera/camera.dart';


List<CameraDescription> cameras;

Future<Null> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());

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

class DrawerOnly extends StatelessWidget{
  @override
  Widget build(BuildContext ctxt) {
    return new Drawer(
    child: new ListView(
    children:<Widget>[
      Container(
      height: 55.0,
      child: DrawerHeader(
          child: Text('Categories', style: TextStyle(color: Colors.white , fontSize: 18.0)),
          decoration: BoxDecoration(
              color: Colors.blue
          ),
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.all(0.0)
      ),
    ),
      new ListTile(
        title: new Text("Home"),
          leading: Icon(Icons.home),
          //tileColor: Colors.cyan,
          trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){
          Navigator.pop(ctxt);
          Navigator.push(ctxt, new MaterialPageRoute(builder: (ctxt) => new MyHomePage(cameras)));
        },
          selectedTileColor: Colors.amber
      ),
    new ListTile(
    leading: CircleAvatar(
    backgroundImage: NetworkImage('https://motorblock.at/wp-content/uploads/2018/09/Tom-der-Abschleppwagen.jpg'),
    ),
      trailing: Icon(Icons.keyboard_arrow_right),
    title: new Text("Puksiirauto Tom"),
    onTap: (){
    Navigator.pop(ctxt);
    Navigator.push(ctxt, new MaterialPageRoute(builder: (ctxt) => new SecondPage()));
    },
    ),
    new ListTile(
    leading: CircleAvatar(
    backgroundImage: NetworkImage('https://specials-images.forbesimg.com/imageserve/5fd7928e1f37990503a26dbb/960x0.jpg?fit=scale'),
    ),
    title: new Text("CoComelon Baby"),
      trailing: Icon(Icons.keyboard_arrow_right),
    onTap: (){
    Navigator.pop(ctxt);
    Navigator.push(ctxt, new MaterialPageRoute(builder: (ctxt) => new CoComelonBabyPage()));
    },
    )
    ],
    )
    );

  }
}
class MyHomePage extends StatefulWidget {
  var cameras;
  MyHomePage(this.cameras);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

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
                Tab(icon: Icon(Icons.play_arrow)),
                Tab(icon: Icon(Icons.camera_alt)),
              ],
        ),
      ),
        body:
        new TabBarView(
        controller: _tabController,
          children: <Widget>[
            VideoItemList(),
            CameraScreen(widget.cameras),
          ],
      ),
        /*body: new ListView(
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
      ),*/
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




