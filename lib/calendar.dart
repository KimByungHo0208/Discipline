import 'package:flutter/material.dart';
import 'package:discipline/designs.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String _eventsKey = 'calendar_events_data';

//marker 위치
Map<DateTime, List<Event>> events = {};

//시간 저장할 객체
class Event{
  String readingTime;
  Event(this.readingTime);

  //Event객체 -> Json맵
  Map<String, dynamic> toJson()=>{
    'readingTime': readingTime,
  };

  //Json맵 -> Event 객체
  factory Event.fromJson(Map<String, dynamic> json)=>Event(json['readingTime'] as String);

  @override
  String toString()=>readingTime;
}
//로컬 저장소에 저장
//events 맵을 sharedPreferences에 저장
Future<void> saveEventsToPrefs() async{
  final prefs = await SharedPreferences.getInstance(); //인스턴스 가져오기
  Map<String, List<Map<String, dynamic>>> jsonEvents = {};
  events.forEach((dateTime, eventList){
    jsonEvents[dateTime.toIso8601String()] = eventList.map((event) => event.toJson()).toList();
  });
  try{
    await prefs.setString(_eventsKey, jsonEncode(jsonEvents));
    print('success to saving events => Json');
  }catch(e){
    print('Error saving events => Json : $e' );
  }
}
//로컬 저장소에 저장한거 가져옴
//sharedPreferences에서 events 맵을 가져오기
Future<void> loadEventsFromPrefs() async{
  final prefs = await SharedPreferences.getInstance();
  try{
    final String? eventsString = prefs.getString(_eventsKey);
    if(eventsString == null || eventsString.isEmpty){
      print('is null or empty');
      events = {};
      return;
    }
    final Map<String, dynamic> jsonEvents = jsonDecode(eventsString);
    Map<DateTime, List<Event>> loadedEvents = {};
    jsonEvents.forEach((dateString, eventDataList){
      final dateTime = DateTime.parse(dateString);
      final utcDateTime = DateTime.utc(dateTime.year, dateTime.month, dateTime.day);
      if(eventDataList is List){
        loadedEvents[utcDateTime] = eventDataList.map((eventData) => Event.fromJson(eventData as Map<String, dynamic>)).toList();
      }
    });
    events = loadedEvents;
    print('success loading json -> events');
  }catch(e){
    print('error loading json -> events : $e');
    events = {};
  }
}

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _loadedDataAndInitialize();
  }

  Future<void> _loadedDataAndInitialize() async{
    //loadEventsFromPrefs가 끝날때까지 다음 줄로 넘어가지 않음
    await loadEventsFromPrefs();
    _selectedEvents.value = _getEventsForDay(_selectedDay!);
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  //이벤트 있으면 events[day], null 이면 빈 리스트 반환
  List<Event> _getEventsForDay(DateTime day){
    final today = DateTime.utc(day.year, day.month, day.day);
    return events[today] ?? [];
  }
  //선택한 날 지정
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay){
    if(!isSameDay(_selectedDay, selectedDay)){
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Calendar',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TableCalendar<Event>(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.utc(2050, 12, 31),
            focusedDay: _focusedDay,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day){
              return isSameDay(_selectedDay, day);
            },
            //header
            headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextFormatter: (date, locale) => DateFormat.yMMMM(locale).format(date),
                formatButtonVisible: false,
                titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
            ),
            //calendar
            calendarStyle: CalendarStyle(
              markerSize:10,
              //marker color
              markerDecoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              markerMargin: const EdgeInsets.symmetric(horizontal:1),
              markersMaxCount: 3,
              outsideDaysVisible: true,
              weekendTextStyle: TextStyle(color: Colors.lightBlueAccent),
              //selected day mark
              selectedDecoration: BoxDecoration(
                color: Colors.cyan,
                shape: BoxShape.circle,
              ),
              //today mark
              todayDecoration: BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: _onDaySelected,
            //내가 선택한 날짜가 다른 달로 넘어가면 초기화됨. 그걸 막는거임
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },

          ),
          const SizedBox(height: 8.0,),
          Expanded(
            //event list on selected day
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _){
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index){
                    final item = value[index].readingTime;
                    //dismissible list
                    return Dismissible(
                      background: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        //behind box deco
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                      ),
                      //swipe animation => 아직 잘 모르겠음
                      resizeDuration: Duration(milliseconds: 200),
                      movementDuration: Duration(milliseconds: 200),
                      key: Key(item),
                      direction: DismissDirection.startToEnd, //left=>right swipe
                      onDismissed: (direction){
                        setState(() {
                          if(direction == DismissDirection.startToEnd){
                            value.removeAt(index);
                            saveEventsToPrefs();
                          }
                        });
                      },
                      child: ListTile(
                        onTap: () {},
                        title: Text(value[index].readingTime),
                      ),

                    );
                  }
                );
              },
            )
          ),
        ],
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}


