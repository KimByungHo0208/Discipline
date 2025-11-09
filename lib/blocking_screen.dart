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
              Flexible(
                flex: 5,
                fit: FlexFit.loose,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    height: 300,
                    width: 300,
                    image: AssetImage('assets/winter.jpg'),
                    fit: BoxFit.fill,
                  )
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Container(
                  alignment: Alignment.center,
                  child: Text('넌 또 나약해지려하고 있어.\n 정신차려.', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.loose,
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 80,
                  width: 240,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('CLOSE BUTTON', style: TextStyle(color: mainColor, fontSize: 30))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// 사용자가 직접 설정화면으로 이동하는 코드
// import 'package:device_apps/device_apps.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
//
// Future<void> requestUsageAccessPermission() async {
//   const intent = AndroidIntent(
//     action: 'android.settings.USAGE_ACCESS_SETTINGS',
//   );
//   await intent.launch();
