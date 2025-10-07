import 'package:flutter/material.dart';
import 'designs.dart';

class RegisteringAppPage extends StatelessWidget {
  const RegisteringAppPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBar(
        title: 'REGISTERING APPS',
      ),
      body: RegisteringAppDesign(),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
