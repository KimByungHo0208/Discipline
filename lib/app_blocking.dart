import 'package:flutter/material.dart';
import 'package:discipline/designs.dart';

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
          AppListDesign(),
          AppListDesign(),
          AppListDesign(),
        ],
      ),

      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
