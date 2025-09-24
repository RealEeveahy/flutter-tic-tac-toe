import 'package:flutter/material.dart';
import 'view/splash.dart';
import 'model/session_model.dart';

late PlayerSession game;
void main(){
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: SplashScreen()
    );
  }
}
