import 'package:flutter/material.dart';
import 'package:garkproject/pages/Auth/Login.dart';
import 'package:garkproject/pages/Dashboard/Home.dart';
import 'package:garkproject/pages/Equipe/AddEquipe.dart';
import 'package:garkproject/pages/Calendrier/Calendrier.dart';
import 'package:garkproject/pages/Equipe/Equipe.dart';
import 'package:garkproject/pages/Notifications/Notifications.dart';
import 'package:garkproject/pages/Settings/Profile.dart';
import 'package:garkproject/pages/Settings/Setting.dart';
import 'package:garkproject/pages/Splash/splash_screen.dart';
import 'package:garkproject/pages/my_drawer_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gark Club',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
      ),
      routes: {
      //'/': (context) => HomeScreen(),
        '/': (context) => SplashScreen(),
        '/home': (context) => const HomePage(),
        '/equipe': (context) => const Equipe(),
        '/notifications': (context) => const Notifications(),
        '/calendrier': (context) => const Calendrier(),
        '/profile': (context) => const Profile(),
        '/setting': (context) => const Setting(),
        '/HomeScreen': (context) => const HomeScreen(),
        '/login': (context) => const Login(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

SharedPreferences? prefs;
String? _clubid;
String _clubName = "";
String cn = "";
late Future<bool> fetchedDocs;
var data = [];

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> fetchDocs() async {
    prefs = await SharedPreferences.getInstance();
    _clubid = prefs!.getString("participantClub");
    cn = prefs!.getString("nameClub")!;

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/clubs/" + _clubid!),
        headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _clubName = data["nameClub"];

      setState(() {
        _clubName = data["nameClub"];
      });
    }

    return true;
  }

  @override
  void initState() {
    fetchedDocs = fetchDocs();

    super.initState();
  }

  int selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    Calendrier(),
    Equipe(),
    Notifications(),
    HomePage(),
    Profile(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _itemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[selectedIndex].currentState!.maybePop();

          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(children: <Widget>[
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.black)),
                child: Center(
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                _clubName,
                style: const TextStyle(),
              ),
            ]),
            backgroundColor: Color.fromARGB(255, 2, 0, 50),
          ),
          // new drawer
          drawer: Drawer(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    MyHeaderDrawer(),
                    MyDrawerList(),
                  ],
                ),
              ),
            ),
          ),

          //body: container,
          body: PageView(
            controller: _pageController,
            children:
                // add routes
                _screens,
            onPageChanged: _onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
          ),
          bottomNavigationBar: navbar,
        ));
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(
              1, "Calendrier", Icons.event, selectedIndex == 0 ? true : false),
          Divider(),
          menuItem(
              2, "Equipe", Icons.groups, selectedIndex == 1 ? true : false),
          Divider(),
          menuItem(3, "Notifications", Icons.notifications,
              selectedIndex == 2 ? true : false),
          Divider(),
          menuItem(4, "Dashboard", Icons.dashboard_outlined,
              selectedIndex == 3 ? true : false),
          Divider(),
          menuItem(5, "Profile", Icons.people_alt_outlined,
              selectedIndex == 4 ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              _itemTapped(id - 1);
            } else if (id == 2) {
              _itemTapped(id - 1);
            } else if (id == 3) {
              _itemTapped(id - 1);
            } else if (id == 4) {
              _itemTapped(id - 1);
            } else if (id == 5) {
              _itemTapped(id - 1);
            } else if (id == 6) {
              _itemTapped(id - 1);
            } else if (id == 7) {
              _itemTapped(id - 1);
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get navbar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        onTap: _itemTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        backgroundColor: Color.fromARGB(255, 2, 0, 50),
        unselectedItemColor: Color.fromARGB(255, 255, 255, 255),
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        iconSize: 20,
        selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            fontFamily: "Poppins",
            letterSpacing: 0.5),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.calendar_month,
                size: 25,
              ),
            ),
            label: "Calendrier",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.accessibility_outlined,
                size: 25,
              ),
            ),
            label: "Equipe",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(1.0),
              child: Icon(
                Icons.notifications,
                size: 25,
              ),
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.home,
                size: 25,
              ),
            ),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.account_circle_rounded,
                size: 25,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          Calendrier(),
          Equipe(),
          Notifications(),
          HomePage(),
          Profile(),
          Setting(),
        ].elementAt(index);
      },
    };
  }
/*
  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }*/
}
