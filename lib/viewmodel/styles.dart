import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({required this.child, this.onPressed, super.key});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle( 
        backgroundColor: WidgetStatePropertyAll(Colors.blue[300]),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)))
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class MainTextStyle extends StatelessWidget {
  const MainTextStyle({required this.content, super.key});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
      fontSize: 30
      ),
    );
  }
}