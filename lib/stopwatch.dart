import 'package:flutter/material.dart';
import 'package:discipline/calendar.dart';
import 'dart:async';

class StopwatchScreen extends ChangeNotifier {
  final Stopwatch _stopwatch = Stopwatch();
  String displayTime = '00:00:00.00';
  Timer? _timer;
  bool get running => _stopwatch.isRunning;

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime(){
    _timer = Timer.periodic(const Duration(milliseconds:10), (timer){
      if(running){
        displayTime = _formatTime(_stopwatch.elapsed);
        notifyListeners();
      }
      else{
        _timer?.cancel();
      }
    });
  }

  //formating
  String _formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hour = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = twoDigits(duration.inMilliseconds.remainder(1000) ~/ 10);
    return '$hour:$minutes:$seconds.$milliseconds';
  }

  void startStopwatch(){
    if(!running){
      _stopwatch.start();
      _updateTime();
      notifyListeners();
    }
  }

  void stopStopwatch(){
    if(running){
      _stopwatch.stop();
      _timer?.cancel();
      _updateTime();
      notifyListeners();
    }
  }

  void resetStopwatch(){
    _stopwatch.stop();
    _stopwatch.reset();
    displayTime = '00:00:00.00';
    _timer?.cancel();
    notifyListeners();
  }

  void saveStopwatch(){
    _stopwatch.stop();
    if(displayTime == '00:00:00.00') return;
    final now = DateTime.now();
    final today = DateTime.utc(now.year, now.month, now.day);
    if(!events.containsKey(today)){
      events[today] = [Event(displayTime)];
    }else{
      events[today]?.add(Event(displayTime));
    }

    //error massage
    saveEventsToPrefs().then((_){}).catchError((error){
      print('error while saving events : $error');
    });

    _stopwatch.reset();
    displayTime = '00:00:00.00';
    _timer?.cancel();
    notifyListeners();
  }

}