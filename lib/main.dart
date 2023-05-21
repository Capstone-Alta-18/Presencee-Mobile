import 'package:flutter/material.dart';
import 'package:presencee/view/homepage/homePage.dart';
import 'package:presencee/view/splashscreen/splashView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
