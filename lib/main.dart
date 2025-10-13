import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:discipline/home_page.dart';
import 'package:discipline/stopwatch.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:discipline/dark_mode.dart';

void main() async {
  await initializeDateFormatting();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>DarkMode()),
        ChangeNotifierProvider(create: (context)=>StopwatchScreen()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}