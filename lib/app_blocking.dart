import 'package:flutter/material.dart';
import 'package:discipline/designs.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:discipline/app_info.dart';
import 'dart:async';

class AppBlocking extends StatelessWidget {
  const AppBlocking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'APP BLOCKING',
      ),
      body: Container(
          alignment: Alignment.center,
          child: TextButton(onPressed: (){}, child: Text('example')),
      ),

      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
