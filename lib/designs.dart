import 'package:flutter/material.dart';
import 'package:discipline/site_blocking.dart';
import 'package:discipline/calendar.dart';
import 'package:discipline/book.dart';
import 'package:discipline/main.dart';
import 'package:discipline/app_blocking.dart';
import 'package:provider/provider.dart';
import 'package:discipline/registering_app.dart';
import 'package:discipline/installedApps.dart';

const Color mainColor = Colors.black54;
const double myAppBarHeight = 80.0;
double titleSize = 40;
double iconSize = 50;

//default app bar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    final darkMode = Provider.of<DarkMode>(context);
    Color objectDarkMode = darkMode.isDark ? Color.fromRGBO(202, 196, 208, 1) : Color.fromRGBO(73, 69, 79, 1);
    Color backgroundDarkMode = darkMode.isDark ? Color.fromRGBO(73, 69, 79, 1) : Color.fromRGBO(202, 196, 208, 1);

    return AppBar(
        toolbarHeight: myAppBarHeight,
        backgroundColor: backgroundDarkMode,
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SideBar()));
            }, icon: Icon(Icons.menu, size: iconSize,color: objectDarkMode,));
          }
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: titleSize, color: objectDarkMode,),
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
    Color objectDarkMode = darkMode.isDark ? Color.fromRGBO(202, 196, 208, 1) : Color.fromRGBO(73, 69, 79, 1);
    Color backgroundDarkMode = darkMode.isDark ? Color.fromRGBO(73, 69, 79, 1) : Color.fromRGBO(202, 196, 208, 1);

    return BottomAppBar(
      color : backgroundDarkMode,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //sleeping
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Calendar()));
          }, icon: Icon(Icons.calendar_month, size: iconSize, color: objectDarkMode,),),
          //reading
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Book()));
          }, icon: Icon(Icons.book, size: iconSize,color: objectDarkMode,)),
          //Main
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
          }, icon: Icon(Icons.home, size: iconSize,color: objectDarkMode,)),
          //app block
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppBlocking()));
          }, icon: Icon(Icons.app_blocking, size: iconSize,color: objectDarkMode,)),
          //site block
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SiteBlocking()));
          }, icon: Icon(Icons.block, size: iconSize,color: objectDarkMode,)),
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
            child: Text('SIDE BAR', style: TextStyle(fontWeight: FontWeight.w900, fontSize: titleSize,)),
          ),
          //add list
          ListTile(
            title: Text('LIST 1', style: TextStyle(color: Colors.blue),),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('LIST 2', style: TextStyle(color: Colors.green),),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('LIST 3', style: TextStyle(color: Colors.pink),),
            onTap: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
      );
  }
}

// app list tile design
class AppListDesign extends StatefulWidget {
  const AppListDesign({super.key});

  @override
  State<AppListDesign> createState() => _AppListDesignState();
}

class _AppListDesignState extends State<AppListDesign> {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay? endTime;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/winter.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(child: Text('app name')),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextButton(onPressed: (){}, child: Text('blocking on / off button')),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextButton(onPressed: () async {
                        // setting start time and end time
                        final TimeOfDay? startTimeOfDay = await showTimePicker(
                          context: context,
                          initialTime: startTime,
                        );

                        // 위젯이 사라졌다면 context 사용 x
                        // await or async를 사용하면 중간에 프레임워크가 위젯을 지워버릴 수도 있는데
                        // 이때 다시 context를 불러오면 크래시가 날 수 있기 때문
                        if(!mounted) return;

                        final TimeOfDay? endTimeOfDay = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (startTimeOfDay != null && endTimeOfDay != null) {
                          setState(() {
                            startTime = startTimeOfDay;
                            endTime = endTimeOfDay;
                          });
                        }
                      }, child: Text(endTime == null ? '00 : 00 ~ 00 : 00' : '${startTime.hour} : ${startTime.minute} ~ ${endTime?.hour} : ${endTime?.minute}')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
        child: Expanded(
          child: TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisteringAppPage()));
            },
            child: Text('ADD APP'),
          ),
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
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/winter.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex : 5,
                      child: Center(child:Text('app name'))),
                    Expanded(
                      flex: 5,
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            CheckedAppList.add('app name');
                            checked ? checked = false : checked = true;
                          });
                        },
                        icon: checked ? Icon(Icons.check_circle_outline) : Icon(Icons.add_circle_outline),
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
  }
}
