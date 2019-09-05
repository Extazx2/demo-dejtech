import 'package:flutter/material.dart';
import 'package:flutter_demo_dej_tech/animated_container.dart';
import 'package:flutter_demo_dej_tech/home_page.dart';
import 'package:flutter_demo_dej_tech/splash_screen.dart';
import 'package:flutter_demo_dej_tech/todo_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => AnimatedContainerPage(),
        "/home": (context) => MyHomePage(title: "Démo Hot Reload !"),
        "/list": (context) => TodoListScreen(),
      },
    );
  }
}