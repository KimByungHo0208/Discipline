import 'package:flutter/material.dart';
import 'package:discipline/designs.dart';

class SiteBlocking extends StatelessWidget {
  const SiteBlocking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'SITE BLOCKING',
      ),
      body: Container(
          alignment: Alignment.center,
          child: Text('SITE BLOCKING BODY')
      ),

      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
