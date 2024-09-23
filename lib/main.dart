import 'package:flutter/material.dart';

import 'attendance_list/attendance_list.dart';

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
      home: AttendanceListScreen(),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
