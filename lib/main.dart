import 'package:flutter/material.dart';
import 'package:home_me/fieldScreen.dart';
import 'package:home_me/model/inscreption.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home:FormScreen(
      ),

    );
  }


  }










