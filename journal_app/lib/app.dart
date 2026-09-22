
import 'package:flutter/material.dart';
import 'package:journal_app/screens/journal_homescreen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
   Widget build(BuildContext context) {
    return MaterialApp(title: 'My App', debugShowCheckedModeBanner: false, home: JournalHomeScreen(),);
    }
  }
