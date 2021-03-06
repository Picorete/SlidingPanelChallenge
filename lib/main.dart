import 'package:challenges/mainController.dart';
import 'package:challenges/pages/home.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Challenge',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
