import 'dart:async';

import 'package:flutter/material.dart';
import 'package:helloworld/Login.dart';
import 'package:helloworld/Welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late SharedPreferences localStorage;
  String user="user";
  String role="";
  late SharedPreferences preferences;

  Future<void> checkRoleAndNavigate() async {
    preferences = await SharedPreferences.getInstance();
    role = (preferences.getString("role") ?? '');

    if (role == user)
    {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Welcome()));
    } else
    {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) =>Login()));
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return Timer(duration, checkRoleAndNavigate);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:30.0),
                child: Image.asset("Images/Splash.jpg"),
              ),

            ]
        ),
      ),
    );


  }
}