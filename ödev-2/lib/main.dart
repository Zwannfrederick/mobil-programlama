import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'odev',
      home: ColorTransitionScreen(),
    );
  }
}

class ColorTransitionScreen extends StatefulWidget {
  @override
  _ColorTransitionScreenState createState() => _ColorTransitionScreenState();
}

class Colorbutton extends StatelessWidget {
  final VoidCallback onPressed;

  Colorbutton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Rengi Değiştir'),
    );
  }
}

class _ColorTransitionScreenState extends State<ColorTransitionScreen> {
  Color backgroundColor = Color(0xFF000080);
  bool isNavyBlue = true;

  void _toggleColor() {
    setState(() {
      if (isNavyBlue) {
        backgroundColor = Colors.yellow;
      } else {
        backgroundColor = Color(0xFF000080);
      }
      isNavyBlue = !isNavyBlue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uygulama'),
      ),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Colorbutton(
            onPressed: _toggleColor,
          ),
        ),
      ),
    );
  }
}
