import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.toInt();
    int height = MediaQuery.of(context).size.height.toInt();
    String pictureUrl = reloadPictureUrl(width, height);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(pictureUrl)),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      imageCache.clear();
                    });
                  },
                  child: Icon(Icons.cloud_download),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String reloadPictureUrl(int width, int height) {
    return "https://picsum.photos/$width/$height";
  }
}
