import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//_checkedListKey 라는 이름으로 checked list 를 저장
const String _checkedListKey = 'checked_list_data';
const String _duringTimeKey = 'during_time_data';

// 지금 깔려있는 전체 앱들
List<AppInfo> allApps = [];
List<CheckedRegistering> checkedAppList = [];
Map<String?, List<TimeOfDay>> duringTime = {};

// 체크 되었는지를 저장할 객체
class CheckedRegistering{
  String packageName;
  bool checked = false;
  CheckedRegistering(this.packageName, this.checked,);

  // app info bool >> json
  Map<String, dynamic> toJson()=>{
    'packageName' : packageName,
    'checked' : checked,
  };

  //json >> app info element
  factory CheckedRegistering.fromJson(Map<String, dynamic> json){
    return CheckedRegistering(
      json['packageName'] as String,
      json['checked'] as bool,
    );
  }
}
// TimeOfDay 전용 json 확장 정의
extension TimeOfDayJson on TimeOfDay {
  Map<String, int> toJson() => {
    'hour': hour,
    'minute': minute,
  };

  static TimeOfDay fromJson(Map<String, dynamic> json) {
    return TimeOfDay(hour: json['hour'], minute: json['minute']);
  }
}


//로컬 저장소에 저장
//checked list를 sharedPreferences에 저장
Future<void> saveAppListToPrefs() async{
  //인스턴스 가져오기
  final prefs = await SharedPreferences.getInstance();
  // name과 checked 값을 저장할 리스트
  try{
    List<Map<String, dynamic>> jsonSaveCheckedList = checkedAppList.map((e) => e.toJson()).toList();;
    Map<String, List<Map<String, int>>> jsonSaveDuringTime = duringTime
        .map((key, value) => MapEntry(
          key!,
          value.map((e) => e.toJson()).toList()
      ),
    );
    // key와 함께 jsonCheckedList를 문자열로 변환하여 저장
    await prefs.setString(_checkedListKey, jsonEncode(jsonSaveCheckedList));
    await prefs.setString(_duringTimeKey, jsonEncode(jsonSaveDuringTime));
    print('success to saving check list => Json');
  }catch(e){
    print('Error [saving check list => Json] : $e' );
  }
}

//로컬 저장소에 저장한거 가져옴
//sharedPreferences에서 checked list 를 가져오기
Future<List<CheckedRegistering>> loadAppListFromPrefs() async{
  final prefs = await SharedPreferences.getInstance();
  try{
    // 만약 json name 이 없다면 빈 리스트 반환
    final String? jsonCheckedListName = prefs.getString(_checkedListKey);
    final String? jsonDuringTimeName = prefs.getString(_duringTimeKey);
    if(jsonCheckedListName == null || jsonCheckedListName.isEmpty){
      print(' [ json app list is null or empty ] ');
      checkedAppList = [];
      return[];
    }
    if(jsonDuringTimeName == null || jsonDuringTimeName.isEmpty){
      print(' [ json during time is null or empty ] ');
      duringTime = {};
      return[];
    }
    // jsonName(json) 을 객체 리스트 로 반환 >> checked app list들
    // json 저장된 값들은 List<map<string, dynamic>> 형태로 저장됨
    // 그래서 as List를 함으로써 명시적으로 list라고 알려줌
    // e는 element,fromJson을 함으로써 각 요소들을 객체에 맞는 형태로 변환
    final List<CheckedRegistering> jsonLoadCheckedList = (jsonDecode(jsonCheckedListName) as List)
        .map((e) => CheckedRegistering.fromJson(e)).toList();
    final Map<String?, List<TimeOfDay>> jsonLoadDuringTime = (jsonDecode(jsonDuringTimeName) as Map<String, dynamic>)
        .map((key, value) => MapEntry(key,
      (value as List).map((e) => TimeOfDay(
        hour: e['hour'],
        minute: e['minute'],
      )).toList(),
    ));

    // 반환한 객체를 담을 리스트
    List<CheckedRegistering> loadedAppList = [];
    Map<String?, List<TimeOfDay>> loadDuringTime = jsonLoadDuringTime.map((key, value) => MapEntry(key,List<TimeOfDay>.from(value)));
    for (var checkedApp in jsonLoadCheckedList) {
      loadedAppList.add(checkedApp);
    }

    checkedAppList = loadedAppList;
    duringTime = loadDuringTime;
    print('success loading json -> check list');
    return checkedAppList;
  }catch(e){
    print('error [loading json -> check list] : $e');
    checkedAppList = [];
    return [];
  }
}

class AppInfo {
  String name;
  Uint8List? icon;
  String packageName;
  int installedTimestamp;
  bool isChecked;

  AppInfo({
    required this.name,
    required this.icon,
    required this.packageName,
    required this.installedTimestamp,
    required this.isChecked,
  });

  factory AppInfo.create(dynamic data) {
    return AppInfo(
      name: data["name"],
      icon: data["icon"],
      packageName: data["package_name"],
      installedTimestamp: data["installed_timestamp"] ?? 0,
      isChecked : false,
    );
  }

  static List<AppInfo> parseList(dynamic app) {
    if (app == null || app is! List || app.isEmpty) return [];
    final List<AppInfo> appInfoList = app
        .where(
          (element) =>
              element is Map &&
              element.containsKey("name") &&
              element.containsKey("package_name"),
        )
        .map((app) => AppInfo.create(app))
        .toList();
    appInfoList.sort((a, b) => a.name.compareTo(b.name));
    return appInfoList;
  }
}
