import 'package:flutter/services.dart';
import 'package:discipline/app_info.dart';

List<String> CheckedAppList = [];

class InstalledApps {

  // communication with native by method channel
  static const MethodChannel _channel = MethodChannel('installed_apps');

  // get installed app's information and return to list
  static Future<List <AppInfo>> getInstalledApps([
    bool excludeSystemApps = true,
    bool withIcon = false,
    String packageNamePrefix = "",
    BuiltWith platformType = BuiltWith.flutter,
  ]) async {
    dynamic apps = await _channel.invokeMethod(
      "getInstalledApps",
      {
        "exclude_system_apps" : excludeSystemApps,
        "with_icon" : withIcon,
        "package_name_prefix" : packageNamePrefix,
        "platform_type" : platformType.name,
      }
    );
    return AppInfo.parseList(apps);
  }

  // return to boolean whether this app is running
  static Future<bool?> startApp(String packageName) async{
    return _channel.invokeMethod(
      "startApp",
      { "packageName" : packageName, }
    );
  }

  // open setting screen(app info) with package name
  static openSettings(String packageName){
    _channel.invokeMethod(
      "openSettings",
      {"package_name" : packageName},
    );
  }

  // toasting message, if message time is short then isShortLength is true
  static toast(String message, bool isShortLength){
    _channel.invokeMethod(
      "toast",
      {
        "message" : message,
        "is_short_length" : isShortLength,
      }
    );
  }

  // get app info
  // Since you saved it as map, you can get the app info if you know the package name
  static Future<AppInfo?> getAppInfo(String packageName, BuiltWith? platformType,) async {
    var app = await _channel.invokeMethod(
      "getAppInfo",
      {
        "package_name" : packageName,
        "Built_with" : platformType?.name ?? '',
      }
    );
    if(app == null){
      return null;
    }else{
      return AppInfo.create(app);
    }
  }

  // return a boolean indicating whether this app is a system app
  static Future<bool?> isSystemApp(String packageName) async{
    return _channel.invokeMethod(
      "isSystemApp",
      {
        "package_name" : packageName,
      }
    );
  }
}
