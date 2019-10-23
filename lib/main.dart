import 'dart:ui';

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
  double blurEffect = 0.0;

  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.toInt();
    int height = MediaQuery.of(context).size.height.toInt();
    String pictureUrl = reloadPictureUrl(width, height);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(pictureUrl)),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurEffect, sigmaY: blurEffect),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 32.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Container(
                            height: 40,
                            color: Colors.white54,
                            child: Slider(
                              min: 0,
                              divisions: 10,
                              max: 11,
                              value: blurEffect,
                              onChanged: (value) {
                                setState(() {
                                  blurEffect = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          imageCache.clear();
                          pictureUrl = reloadPictureUrl(width, height);
                        });
                      },
                      child: Icon(Icons.cloud_download),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ],
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
