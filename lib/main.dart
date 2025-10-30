import 'package:flutter/material.dart';
import 'package:practica2/models/persona.dart';
import 'package:practica2/screens/home_page.dart';
import 'package:practica2/screens/personal_page.dart';
import 'package:practica2/screens/widget_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Practica 2",
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/screens/personal_page.dart': (context) => PersonalPage(persona: context as Persona),
        '/screens/widget_page.dart': (context) => WidgetPage(),
      },
    );
  }
}