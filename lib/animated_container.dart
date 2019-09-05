import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {

  double _width = 150;
  double _height = 150;
  Color _color = Colors.greenAccent;
  BorderRadiusGeometry _borderRadiusGeometry = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Container Demo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            tooltip: "Page suivante",
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          IconButton(
            icon: Icon(Icons.navigate_next),
            tooltip: "Playons",
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Center(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadiusGeometry,
          ),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            final random = Random();

            // random width and height
            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();

            // random color
            _color = Color.fromRGBO(
              random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
                1
            );

            // random border
            _borderRadiusGeometry = BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
      ),
    );
  }
}