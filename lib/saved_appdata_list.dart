import 'package:flutter/material.dart';
import 'package:discipline/designs.dart';
import 'package:discipline/view_data_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedAppDataList extends StatefulWidget {
  const SavedAppDataList({super.key});

  @override
  State<SavedAppDataList> createState() => _SavedAppdataListState();
}

class _SavedAppdataListState extends State<SavedAppDataList> {
  List<String> keys = [];

  @override
  void initState() {
    super.initState();
    _loadKeys();

  }

  Future<void> _loadKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys().toList();

    setState(() {
      keys = allKeys;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: MyAppBar(
          title: 'save data',
        ),
        body: ListView.builder(
          itemCount: keys.length,
          itemBuilder: (context, index) {
            final key = keys[index];

            return ListTile(
              title: Text(key),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ViewDataScreen(prefKey: key),
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: MyBottomAppBar(),
      ),
    );
  }
}
