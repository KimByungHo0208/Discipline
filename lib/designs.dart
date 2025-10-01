import 'package:flutter/material.dart';
import 'package:discipline/site_blocking.dart';
import 'package:discipline/calendar.dart';
import 'package:discipline/book.dart';
import 'package:discipline/main.dart';
import 'package:discipline/app_blocking.dart';
import 'package:provider/provider.dart';

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
