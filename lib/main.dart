import 'package:flutter/material.dart';
import 'view/home_screen.dart';

void main() {
  //load data
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      home: HomeScreen()
    );
  }
}