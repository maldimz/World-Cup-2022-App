import 'package:flutter/material.dart';
import 'package:responsi_app/pages/list_page.dart';

// Name Akhmal Dimas Pratama
// NIM 123200047
// Class IF-H

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }
}
