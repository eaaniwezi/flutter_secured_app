// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:secured_flutter_app/screens/set_pin_code_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IZX',
      debugShowCheckedModeBanner: false,
      home: const SetPinCodeScreen(),
    );
  }
}
