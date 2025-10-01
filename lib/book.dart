import 'package:flutter/material.dart';
import 'package:discipline/designs.dart';
import 'package:provider/provider.dart';
import 'package:discipline/main.dart';
import 'package:discipline/stopwatch.dart';


class Book extends StatelessWidget {
  const Book({super.key});

  @override
  Widget build(BuildContext context) {

    //인스턴스 받아오기
    final darkMode = Provider.of<DarkMode>(context);
    final stopwatch = Provider.of<StopwatchScreen>(context);

    return Scaffold(
      appBar: MyAppBar(
        title: 'BOOK',
      ),
      body: Theme(
        //dark mode
        data: darkMode.isDark ? ThemeData.dark() : ThemeData.light(),

        child: Container(
          //다크모드이면 mainColor, 아니면 white
          color: darkMode.isDark ? mainColor : Colors.white,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  flex: 7,
                  //시작, 정지 버튼
                  child: Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(onPressed: (){
                      darkMode.changeDarkMode();
                      stopwatch.running ? stopwatch.stopStopwatch() : stopwatch.startStopwatch();
                    }, style:ElevatedButton.styleFrom(shape: CircleBorder(), padding: EdgeInsets.all(100)),
                      child: Text(
                          stopwatch.running ? 'STOP' : 'START',
                          style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900)),),
                  )
              ),
              Flexible(
                flex: 1,
                //시간 표시 문자열
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                      stopwatch.displayTime,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: darkMode.isDark? Colors.white : Colors.black)),
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 50,
                    children: [
                      //스톱워치 초기화
                      SizedBox(
                        child: Ink(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(),
                            color: darkMode.isDark? mainColor : Colors.white,
                          ),
                          child: IconButton(onPressed: (){
                            stopwatch.resetStopwatch();
                          }, icon: Icon(Icons.autorenew, size: iconSize,)),
                        ),
                      ),
                      //스톱워치 저장
                      SizedBox(
                        child: Ink(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(),
                            color: darkMode.isDark? mainColor : Colors.white,
                          ),
                          child: IconButton(onPressed: (){
                            stopwatch.saveStopwatch();
                            //밑에 올라오는 창 애니메이션
                            final snackBar = SnackBar(
                              content: const Text('저장되었습니다.'),
                              action: SnackBarAction(label: '', onPressed: (){}),
                              duration: Durations.short4,
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }, icon: Icon(Icons.save, size: iconSize,)),
                        ),
                      ),

                    ],
                  )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}

