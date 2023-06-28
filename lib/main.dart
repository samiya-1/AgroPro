import 'package:flutter/material.dart';
import 'package:helloworld/Welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var kBackgroundColor;

  var kTextColor;



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return

      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agro Pro',
      theme: ThemeData(fontFamily: "cairo",
      scaffoldBackgroundColor: kBackgroundColor,
      textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),),
      home: Welcome(),
      );



  }
}

