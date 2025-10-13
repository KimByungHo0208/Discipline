import 'package:flutter/material.dart';
import 'package:discipline/designs.dart';
import 'package:discipline/blocking_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: MyAppBar(
          title: 'DISCIPLINE',
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('MAIN BODY'),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BlockingScreen()),
                  );
                },
                child: Text('GO TO BLOCKING SCREEN'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}
