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
  // Bu sınıfı tanımlıyoruz
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
  // Fenerbahçe renkleri
  Color backgroundColor = Color(0xFF003DA5);
  bool isNavyBlue = true;

  void _toggleColor() {
    setState(() {
      if (isNavyBlue) {
        backgroundColor = Color(0xFFFFD200);
      } else {
        backgroundColor = Color(0xFF003DA5);
      }
      isNavyBlue = !isNavyBlue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Uygulama',
          style: TextStyle(
            color: backgroundColor == Color(0xFFFFD200)
                ? Colors.black
                : Colors.white,
          ), // Yazı rengi
        ),
        backgroundColor: backgroundColor, // AppBar rengi
      ),
      body: Container(
        color: backgroundColor, // Arka plan rengi
        child: Center(
          child: Colorbutton(
            onPressed: _toggleColor,
          ),
        ),
      ),
    );
  }
}
