import 'package:flutter/material.dart';
import 'package:sid_blog/screens/home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.black
      ),
    ),
  );
}
