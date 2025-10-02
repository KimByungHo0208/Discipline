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
      body: ListView(
        children: [
          AddAppList(),
          AppListDesign(appName: 'winter photo1'),
          AppListDesign(appName: 'winter photo2'),
          AppListDesign(appName: 'winter photo3'),
        ],
      ),

      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
