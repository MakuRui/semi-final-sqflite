import 'package:flutter/material.dart';
import 'package:sqflite_1/pages/home_page.dart';

void main () => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqflite CRUD TodosTask',
      theme: ThemeData(
          primarySwatch: Colors.indigo
      ),
      home: const HomePage(),
    );
  }
}