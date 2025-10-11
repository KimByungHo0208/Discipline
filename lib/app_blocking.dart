import 'package:flutter/material.dart';
import 'package:discipline/designs.dart';
import 'package:discipline/app_info.dart';

class AppBlocking extends StatefulWidget {
  const AppBlocking({super.key});

  @override
  State<AppBlocking> createState() => _AppBlockingState();
}

class _AppBlockingState extends State<AppBlocking> {
  late Future<List<CheckedRegistering>> _loadAppsFuture;

  @override
  void initState() {
    super.initState();
    _loadAppsFuture = loadAppListFromPrefs();
  }
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
            child: FutureBuilder(
                future: _loadAppsFuture,
                builder: (context, AsyncSnapshot snapshot) {
                  // loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  // has error
                  if (snapshot.hasError) {
                    return Center(child: Text('fail to load app list'));
                  }
                  // no data
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('add app list is empty'));
                  }
                  // 4. 데이터 로딩이 성공했을 때
                  // snapshot.data는 loadAppListFromPrefs가 반환한 리스트입니다.
                  // 이 데이터를 AppListDesign에 전달할 수 있습니다.
                  // (AppListDesign이 CheckedRegistering 리스트를 받도록 수정해야 할 수 있습니다.)
                  return AppListDesign();
                }
            ),
          ),
        ],
      ),

      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}
