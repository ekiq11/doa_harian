import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'landing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Doa Harian',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
