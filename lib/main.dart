import 'package:flutter/material.dart';

import 'package:rashan_app/LoginRegisterPage.dart';
import 'package:rashan_app/authentication.dart';
import 'package:rashan_app/homepage.dart';
import 'package:rashan_app/mapping.dart';

void main() => runApp(MyApp());

 class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
      title: 'Rashan App',

      theme: new ThemeData(
        primarySwatch: Colors.deepOrange
      ),

  home: MappingPage(auth:Auth()),

    );
  
  }}