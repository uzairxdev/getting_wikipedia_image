import 'package:flutter/material.dart';
import 'image_display_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Getting Wikipedia Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageDisplayWidget(title: 'Apple Inc.'),
    );
  }
}
