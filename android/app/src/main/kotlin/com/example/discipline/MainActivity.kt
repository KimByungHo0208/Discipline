package com.example.discipline


import android.app.AppOpsManager
import android.content.Context
import android.content.Intent
import android.provider.Settings
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity(){
    private val CHANNEL = "blocking_channel"
    private val EVENT = "event_channel"

    // flutter 엔진이 완전히 초기화된 이후에 호출됨
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // 앱 사용 내역 접근 권한을 얻는 함수
        // result 3개가 있음 > success, error, notimplemented
        // success : 성공 / error : 실패, (string errorCode, string errorMessage, object errorDetails)
        // notimplemented : 구현되지 않았을때
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
            call, result -> when(call.method){
                // method 이름이 checkUsagePermission
                "checkUsagePermission" -> {
                    if(!hasUsagePermission()){
                        // 엑티비티를 전환 >> action_usage_access_settings >> show settings to control access to usage info
                        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                        startActivity(intent)
                    }
                    Log.d("permission", "권한 얻었어요")
                    result.success(hasUsagePermission())
                }
//                "startMonitoring" -> {
//                    var pkgName : String? = ""
//                    monitoringForegroundApp(this){
//                        pkgName -> Log.d("monitoring", "모니터링중")
//                        // log.d는 실행하는 함수
//                        pkgName
//                    };
//                    result.success(pkgName)
//                    Log.d("monitoring", "startmonitoring 실행완료")
//                }
                else -> result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT)
            .setStreamHandler(object : EventChannel.StreamHandler{
                override fun onListen(arguments : Any?, events: EventChannel.EventSink){
                    Log.d("event channel", "in event channel")
                    monitoringForegroundApp(this@MainActivity){
                        pkgName -> Log.d("monitoring", "모니터링중")
                        events.success(pkgName)
                    }
                }
                override fun onCancel(arguments: Any?) {
                    //if cancel...
                }

            })

    }

    private fun hasUsagePermission(): Boolean{
        // 앱 사용 내역 접근 권한
        // used to access system-level-service
        // return handler about system service
        // context.app_ops_service : to retrieve a appOpsManager for tracking app operation
        // appOpsManager : access control and tracking
        val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager

        // check whether app can perform an operation
        // if throwing SecurityException, return MODE_ERRORED
        val mode = appOps.checkOpNoThrow(
            // access to UsageStatsManager
            AppOpsManager.OPSTR_GET_USAGE_STATS,
            android.os.Process.myUid(),
            packageName
        )
        // MODE_ALLOWED : allow the access
        return mode == AppOpsManager.MODE_ALLOWED
    }

}
