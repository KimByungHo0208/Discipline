import 'package:flutter/material.dart';
import 'package:discipline/site_blocking.dart';
import 'package:discipline/calendar.dart';
import 'package:discipline/book.dart';
import 'package:discipline/main.dart';
import 'package:discipline/app_blocking.dart';
import 'package:provider/provider.dart';
import 'package:discipline/registering_app.dart';
import 'package:discipline/app_info.dart';
import 'package:discipline/installedApps.dart';

const Color mainColor = Colors.black54;
const double myAppBarHeight = 80.0;
double titleSize = 40;
double iconSize = 50;

//default app bar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkMode>(context);
    Color objectDarkMode = darkMode.isDark
        ? Color.fromRGBO(202, 196, 208, 1)
        : Color.fromRGBO(73, 69, 79, 1);
    Color backgroundDarkMode = darkMode.isDark
        ? Color.fromRGBO(73, 69, 79, 1)
        : Color.fromRGBO(202, 196, 208, 1);

    return AppBar(
      toolbarHeight: myAppBarHeight,
      backgroundColor: backgroundDarkMode,
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SideBar()),
              );
            },
            icon: Icon(Icons.menu, size: iconSize, color: objectDarkMode),
          );
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: titleSize,
          color: objectDarkMode,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(myAppBarHeight);
}

//default bottom app bar
class MyBottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkMode>(context);
    Color objectDarkMode = darkMode.isDark
        ? Color.fromRGBO(202, 196, 208, 1)
        : Color.fromRGBO(73, 69, 79, 1);
    Color backgroundDarkMode = darkMode.isDark
        ? Color.fromRGBO(73, 69, 79, 1)
        : Color.fromRGBO(202, 196, 208, 1);

    return BottomAppBar(
      color: backgroundDarkMode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //sleeping
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Calendar()),
              );
            },
            icon: Icon(
              Icons.calendar_month,
              size: iconSize,
              color: objectDarkMode,
            ),
          ),
          //reading
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Book()),
              );
            },
            icon: Icon(Icons.book, size: iconSize, color: objectDarkMode),
          ),
          //Main
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            icon: Icon(Icons.home, size: iconSize, color: objectDarkMode),
          ),
          //app block
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AppBlocking()),
              );
            },
            icon: Icon(
              Icons.app_blocking,
              size: iconSize,
              color: objectDarkMode,
            ),
          ),
          //site block
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SiteBlocking()),
              );
            },
            icon: Icon(Icons.block, size: iconSize, color: objectDarkMode),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//side bar
class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    //나중에
    //final darkMode = Provider.of<DarkMode>(context);
    // Color objectDarkMode = darkMode.isDark ? Color.fromRGBO(202, 196, 208, 1) : Color.fromRGBO(73, 69, 79, 1);
    // Color backgroundDarkMode = darkMode.isDark ? Color.fromRGBO(73, 69, 79, 1) : Color.fromRGBO(202, 196, 208, 1);

    //drawer == side bar
    return Drawer(
      child: ListView(
        //important: removed all padding on ListView
        padding: EdgeInsets.zero,
        children: [
          //list head
          DrawerHeader(
            decoration: BoxDecoration(
              color: mainColor,
              //image: DecorationImage(image: AssetImage('assets/winter.jpg'), fit: BoxFit.fill),
            ),
            child: Text(
              'SIDE BAR',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: titleSize,
              ),
            ),
          ),
          //add list
          ListTile(
            title: Text('LIST 1', style: TextStyle(color: Colors.blue)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('LIST 2', style: TextStyle(color: Colors.green)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('LIST 3', style: TextStyle(color: Colors.pink)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// app list tile design
class AppListDesign extends StatefulWidget {

  const AppListDesign({Key? key}) : super(key: key);

  @override
  State<AppListDesign> createState() => _AppListDesignState();
}

class _AppListDesignState extends State<AppListDesign> {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay? endTime;

  @override
  Widget build(BuildContext context) {
    if(checkedAppList.isEmpty){
      return Center(child: Text('add app list is empty'));
    }
    else{
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: checkedAppList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    height: 150,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 3,
                          fit: FlexFit.loose,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: checkedAppList[index].icon != null
                                ? Image(
                              image: MemoryImage(checkedAppList[index].icon!),
                              fit: BoxFit.fill,
                            )
                                : Icon(Icons.apps, size: iconSize),
                          ),
                        ),
                        Flexible(
                          flex: 7,
                          fit: FlexFit.loose,
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                      child: Text(checkedAppList[index].name)),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text('blocking on / off button'),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    onPressed: () async {
                                      // setting start time and end time
                                      final TimeOfDay? startTimeOfDay =
                                      await showTimePicker(
                                        context: context,
                                        initialTime: startTime,
                                      );

                                      // 위젯이 사라졌다면 context 사용 x
                                      // await or async를 사용하면 중간에 프레임워크가 위젯을 지워버릴 수도 있는데
                                      // 이때 다시 context를 불러오면 크래시가 날 수 있기 때문
                                      if (!mounted) return;

                                      final TimeOfDay? endTimeOfDay = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (startTimeOfDay != null &&
                                          endTimeOfDay != null) {
                                        setState(() {
                                          startTime = startTimeOfDay;
                                          endTime = endTimeOfDay;
                                        });
                                      }
                                    },
                                    child: Text(
                                      endTime == null
                                          ? '00 : 00 ~ 00 : 00'
                                          : '${startTime.hour} : ${startTime
                                          .minute} ~ ${endTime
                                          ?.hour} : ${endTime?.minute}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }
}

// add app list tile design
class AddAppList extends StatelessWidget {
  const AddAppList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisteringAppPage()),
            );
          },
          child: Text('ADD APP'),
        ),
      ),
    );
  }
}

// registering app tile design
class RegisteringAppDesign extends StatefulWidget {
  const RegisteringAppDesign({super.key});

  @override
  State<RegisteringAppDesign> createState() => _RegisteringAppDesignState();
}

class _RegisteringAppDesignState extends State<RegisteringAppDesign> {
  List<AppInfo> apps = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loading();
  }

  void loading() async {
    if (apps.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    apps = await InstalledApps.getInstalledApps();
    setState(() {
      isLoading = false;
    });
  }

  void _saveAppList(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppBlocking()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Card(
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: TextButton(
              onPressed: _saveAppList, // 위에서 정의한 함수를 연결합니다.
              child: Text('Save APP'),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: apps.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 150,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        fit: FlexFit.loose,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: apps[index].icon != null
                              ? Image(
                                  image: MemoryImage(apps[index].icon!),
                                  fit: BoxFit.fill,
                                )
                              : Icon(Icons.apps, size: iconSize),
                        ),
                      ),
                      Flexible(
                        flex: 7,
                        fit: FlexFit.loose,
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 5,
                                fit: FlexFit.loose,
                                child: Center(child: Text(apps[index].name)),
                              ),
                              Flexible(
                                flex: 5,
                                fit: FlexFit.loose,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      checkedAppList.add(apps[index]); //번호랑 숫자 세는게 다름
                                      print('index : $index');
                                      apps[index].isChecked
                                          ? apps[index].isChecked = false
                                          : apps[index].isChecked = true;
                                      // print('name : ${apps[index].name}, icon : ${apps[index].icon}');
                                      // print('package name : ${apps[index].packageName}, builtWith : ${apps[index].builtWith}');
                                      // print('installed time : ${apps[index].installedTimestamp}');
                                      print('name : ${checkedAppList[checkedAppCount].name}, checkedAppCount : $checkedAppCount, length : ${checkedAppList.length}'); //exception >> RangeError (length): Invalid value: Only valid value is 0: 1
                                      checkedAppCount++;
                                    });
                                  },
                                  icon: apps[index].isChecked
                                      ? Icon(Icons.check_circle_outline)
                                      : Icon(Icons.add_circle_outline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
