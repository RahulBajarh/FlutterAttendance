import 'dart:async';
import 'package:contata_attendance/pages/cross_over_day.dart';
import 'package:contata_attendance/pages/login.dart';
import 'package:contata_attendance/pages/time_in.dart';
import 'package:contata_attendance/pages/time_out.dart';
import 'package:contata_attendance/utils/common.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/drawer.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  String? currentUser = '';
  var currentTime = "";
  bool isTimeIn = false;

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void setTimeInEntry() {
    isTimeIn = true;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Color _color = Color("0xFF80bb00");
  int _selectedIndex = 0;
  String currentDate = DateFormat('d MMMM y').format(DateTime.now());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? user = '';
  var currentTime = "";
  bool isTimeIn = true;
  bool isTimeOut = false;
  bool isCrossOverDay = false;
  String entryTimeType = "";
  //Color _backgroundColor = Colors.red;

  void toggleDrawerContent(String newValue) {
    entryTimeType = newValue;
    if (entryTimeType == TimeEntryTypeConstraints.timeIn) {
      if (mounted) {
        setState(() {
          isCrossOverDay = false;
          isTimeIn = true;
          isTimeOut = false;
        });
      }
    } else if (entryTimeType == TimeEntryTypeConstraints.timeOut) {
      if (mounted) {
        setState(() {
          isCrossOverDay = false;
          isTimeIn = false;
          isTimeOut = true;
        });
      }
    } else if (entryTimeType == TimeEntryTypeConstraints.crossOverDay) {
      if (mounted) {
        setState(() {
          isCrossOverDay = true;
          isTimeIn = false;
          isTimeOut = false;
        });
      }
    }
  }

  void isSuccess(bool newValue, String timeType) {
    print(newValue);
    print(timeType);
    if (timeType == TimeEntryTypeConstraints.timeIn) {
      setState(() {
        isCrossOverDay = false;
        isTimeIn = newValue;
        isTimeOut = false;
      });
    } else if (timeType == TimeEntryTypeConstraints.timeOut) {
      setState(() {
        isCrossOverDay = false;
        isTimeIn = false;
        isTimeOut = newValue;
      });
    } else if (timeType == TimeEntryTypeConstraints.crossOverDay) {
      setState(() {
        isCrossOverDay = newValue;
        isTimeIn = false;
        isTimeOut = false;
      });
    }
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    if (index == 0) {
      if (mounted) {
        setState(() {
          isCrossOverDay = false;
          isTimeIn = true;
          isTimeOut = false;
        });
      }
    } else if (index == 1) {
      if (mounted) {
        setState(() {
          isCrossOverDay = false;
          isTimeIn = false;
          isTimeOut = true;
        });
      }
    } else if (index == 2) {
      if (mounted) {
        setState(() {
          isCrossOverDay = true;
          isTimeIn = false;
          isTimeOut = false;
        });
      }
    }
  }

// Retrieve user data
  Future<void> retrieveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username') ?? '';
    setState(() {
      user = savedUsername;
    });
  }

  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    if (!mounted) return;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
        });
      }
    });
    super.initState();
    // Call your async function when the page loads
    retrieveCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome $user',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffef4c25),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: _logOut)
          ],
        ),
        backgroundColor: Colors.blue[50],
        drawer: MyDrawer(
          toggleDrawerContent: toggleDrawerContent,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Attendance System',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset('assets/images/contata.png',
                        height: 150, width: 150),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),
            Container(
              height: 2,
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 1),
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.lightBlue[700],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      currentDate,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      currentTime,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome To Contata Solutions',
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                if (!isCrossOverDay) ...[
                  if (isTimeIn) ...[
                    TimeIn(
                      onSubmit: isSuccess,
                    ),
                  ] else ...[
                    TimeOut(
                      onSubmit: isSuccess,
                    ),
                  ],
                ] else ...[
                  CrossOverDay(
                    onSubmit: isSuccess,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),
          ]),
        ),
        bottomNavigationBar: SizedBox(
          height: 70.0,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Time In',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Time Out',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Cross Over Day',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      );
    });
  }
}
