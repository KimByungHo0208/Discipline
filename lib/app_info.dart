import 'dart:typed_data';

class AppInfo {
  String name;
  Uint8List? icon;
  String packageName;
  BuiltWith builtWith;
  int installedTimestamp;

  AppInfo({
    required this.name,
    required this.icon,
    required this.packageName,
    required this.builtWith,
    required this.installedTimestamp,
  });

  factory AppInfo.create(dynamic data) {
    return AppInfo(
      name: data["name"],
      icon: data["icon"],
      packageName: data["package_name"],
      builtWith: parseBuiltWith(data["built_with"]),
      installedTimestamp: data["installed_timestamp"] ?? 0,
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
    return appInfoList;
  }

  static BuiltWith parseBuiltWith(String? BuiltWithRaw) {
    if (BuiltWithRaw == "flutter") {
      return BuiltWith.flutter;
    } else if (BuiltWithRaw == "react_native") {
      return BuiltWith.react_native;
    } else {
      return BuiltWith.native_or_others;
    }
  }
}

enum BuiltWith { flutter, react_native, native_or_others }
