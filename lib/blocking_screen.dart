import 'package:discipline/designs.dart';
import 'package:flutter/material.dart';

class BlockingScreen extends StatelessWidget {
  const BlockingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text('BLOCKING SCREEN'),
              // TextButton(
              //   onPressed: () {
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (context) => MyApp()),
              //     );
              //   },
              //   child: Text('GO TO MAIN'),
              // ),
              Flexible(
                flex: 5,
                fit: FlexFit.loose,
                child: Container(
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(child: Text('APP ICON', style: TextStyle(color: mainColor))),
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: Text('BLOCKING SCREEN'),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 100,
                  width: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('CLOSE', style: TextStyle(color: mainColor))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
