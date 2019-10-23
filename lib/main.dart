import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
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
  String pictureUrl;
  File _image;

  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.toInt();
    int height = MediaQuery.of(context).size.height.toInt();
    ImageProvider selectedImage;
    if (_image == null) {
      reloadPictureUrl(width, height);
      selectedImage = NetworkImage(pictureUrl);
    } else {
      selectedImage = FileImage(_image);
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: selectedImage),
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
                        showImageSelectionBottomSheet(context, width, height);
                      },
                      tooltip: 'Get new image',
                      child: Icon(Icons.image),
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

  void showImageSelectionBottomSheet(
      BuildContext context, int screenWidth, int screenHeight) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    imageCache.clear();
                    reloadPictureUrl(screenWidth, screenHeight);
                    Navigator.of(context).pop();
                  });
                },
                tooltip: 'Internet',
                child: Icon(Icons.cloud_download),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: FloatingActionButton(
                onPressed: () {
                  getImage();
                  Navigator.of(context).pop();
                },
                tooltip: 'Gallery',
                child: Icon(Icons.image),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  reloadPictureUrl(int width, int height) {
    pictureUrl = "https://picsum.photos/$width/$height";
    _image = null;
  }

  Future getImage() async {
    ImagePicker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        _image = value;
      });
    });
  }
}
