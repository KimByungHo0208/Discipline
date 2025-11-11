import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'designs.dart';

class ViewDataScreen extends StatefulWidget {
  final String prefKey;
  const ViewDataScreen({Key? key, required this.prefKey}) : super(key: key);

  @override
  State<ViewDataScreen> createState() => _ViewDataScreenState();
}

class _ViewDataScreenState extends State<ViewDataScreen> {
  dynamic value;

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.get(widget.prefKey);

    setState(() {
      value = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: MyAppBar(
          title: 'view data',
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "저장된 값: $value",
            style: const TextStyle(fontSize: 18),
          ),
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}

