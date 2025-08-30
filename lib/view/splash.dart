import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../model/session.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()
  {
    super.initState();
    InitializeData();
  }
  Future<void> InitializeData() async {

  await Future.delayed(Duration(seconds: 2));
  game = await PlayerSession.create();

  Navigator.pushReplacement(
    context, 
    MaterialPageRoute(builder: (context) => HomeScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}