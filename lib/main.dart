import 'package:crudapp_project/module_13/home_screen.dart';
import 'package:flutter/material.dart';

import 'module_13/Recipe List Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: RecipeList(),

    );
  }
}