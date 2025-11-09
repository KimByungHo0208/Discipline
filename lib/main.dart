import 'package:discipline/background_app_monitoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:discipline/home_page.dart';
import 'package:discipline/stopwatch.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:discipline/dark_mode.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 알림 권한 허용 요청
  await Permission.notification.request().isDenied.then(
      (value){
        if(value){
          Permission.notification.request();
        }
      },
  );
  await initializeDateFormatting();
  await initializeService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>DarkMode()),
        ChangeNotifierProvider(create: (context)=>StopwatchScreen()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel("blocking_channel");
  final _event = const EventChannel("event_channel");
  final service = FlutterBackgroundService();

  @override
  void initState(){
    super.initState();
    _checkPermission();
    service.invoke('stopService');
    //메인 isolate에서 실행시키기위해
    service.on('startMonitoring').listen((event) async{
      print('start print monitoring');
      //final String? appName = await platform.invokeMethod("startMonitoring");
      //print('current app name is $appName');
      _event.receiveBroadcastStream().listen((appName) {
        // event
        print('current app name is $appName');
      });
    });
  }

  Future<void> _checkPermission() async{
    final hasPermission = await platform.invokeMethod("checkUsagePermission");
    if(!hasPermission){
      print('권한을 못 가져왔어요');
    }else{
      print('권한을 가져왔어요');
    }

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}