import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'odev',
      home: ColorTransitionScreen(),
    );
  }
}

class ColorTransitionScreen extends StatefulWidget {
  const ColorTransitionScreen({super.key});

  @override
  _ColorTransitionScreenState createState() => _ColorTransitionScreenState();
}

class ColorButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ColorButton(
      {super.key, required this.onPressed, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Text(
        'Rengi Değiştir',
        style: TextStyle(
          color: backgroundColor == const Color(0xFFFFD200)
              ? const Color(0xFF003DA5)
              : const Color(0xFFFFD200),
        ),
      ),
    );
  }
}

class _ColorTransitionScreenState extends State<ColorTransitionScreen> {
  Color backgroundColor = const Color(0xFF003DA5);
  bool isNavyBlue = true;

  void _toggleColor() {
    setState(() {
      backgroundColor =
          isNavyBlue ? const Color(0xFFFFD200) : const Color(0xFF003DA5);
      isNavyBlue = !isNavyBlue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        color: backgroundColor,
        child: Center(
          child: ColorButton(
            onPressed: _toggleColor,
            backgroundColor:
                isNavyBlue ? const Color(0xFFFFD200) : const Color(0xFF003DA5),
          ),
        ),
      ),
    );
  }
}
