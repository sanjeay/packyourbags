import 'package:flutter/material.dart';

import 'Screens/HomePage.dart';
import 'Screens/buslists.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "pack your bags",
      routes: {
        "/": (context) => HomePage(),
        "/checkroutes": (context) => Bus_lists()
      },
      initialRoute: "/",
    );
  }
}
