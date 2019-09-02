import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(
              size: 400,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/home"); // On ajoute "/home" à la pile de routes
              },
              child: Text("Prochain écran"),
            ),
          ],
        ),
      ),
    );
  }
}