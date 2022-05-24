// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secured_flutter_app/repositories/security_repository.dart';
import 'package:secured_flutter_app/screens/login_pin_code_screen.dart';
import 'package:secured_flutter_app/screens/set_pin_code_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool newUser = true;
  final securityRepository = SecurityRepository();

  @override
  void initState() {
    super.initState();
    checkNewUsers();
  }

  void checkNewUsers() async {
    var isNewUser = await securityRepository.isNewUser();
    newUser = isNewUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IZX',
      debugShowCheckedModeBanner: false,
      home: newUser == true ? SetPinCodeScreen() : LoginPinCodeScreen(),
    );
  }
}
