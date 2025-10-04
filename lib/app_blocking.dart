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
      body: Column(
        children: [
          AddAppList(),
          Expanded(
            child: AppListDesign(),
          ),
        ],
      ),

      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
