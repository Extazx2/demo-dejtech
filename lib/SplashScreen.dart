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
                //Navigator.of(context).pushNamed("/home"); // On ajoute "/home" à la pile de routes
                Navigator.of(context).pushNamedAndRemoveUntil("/home", (Route<dynamic> route) => false);  // on écrase toutes les routes dans la pile, jusque "/home"
              },
              child: Text("Prochain écran"),
            ),
          ],
        ),
      ),
    );
  }
}