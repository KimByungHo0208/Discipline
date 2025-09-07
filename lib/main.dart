import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:discipline/designs.dart';
import 'package:discipline/stopwatch.dart';
import 'package:intl/date_symbol_data_local.dart';

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

class DarkMode extends ChangeNotifier{
  bool _isDarkMode = false;
  bool get isDark => _isDarkMode;

  void changeDarkMode(){
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //light mode
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme:AppBarTheme(
          backgroundColor: mainColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            foregroundColor: Colors.white54,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        )
      ),
      //dark mode
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: mainColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white54,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white54,
            foregroundColor: mainColor,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: mainColor,
          )
      ),
      home:Scaffold(
        appBar: MyAppBar(
          title: 'DISCIPLINE',
        ),
        body: Container(
          alignment: Alignment.center,
          child: Text('MAIN BODY'),
        ),
        bottomNavigationBar: MyBottomAppBar(),
        ),
      );
  }
}