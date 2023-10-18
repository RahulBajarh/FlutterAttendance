import 'package:contata_attendance/utils/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Function(String) toggleDrawerContent;
  const MyDrawer({super.key, required this.toggleDrawerContent});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xffef4c25),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text('Rahul Bazad'),
                accountEmail: Text('rahulb@contata.in'),
                currentAccountPicture: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Color(0xFF778899),
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.time,
                color: Colors.white,
                size: 32,
              ),
              title: const Text(
                'Time In',
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              onTap: (){
                Navigator.of(context).pop();
                toggleDrawerContent(TimeEntryTypeConstraints.timeIn);
              },
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.time,
                color: Colors.white,
                size: 32,
              ),
              title: const Text(
                'Time Out',
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              onTap: (){
                Navigator.of(context).pop();
                toggleDrawerContent(TimeEntryTypeConstraints.timeOut);
              },
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.time,
                color: Colors.white,
                size: 32,
              ),
              title: const Text(
                'Cross Over Day',
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              onTap: (){
                Navigator.of(context).pop();
                toggleDrawerContent(TimeEntryTypeConstraints.crossOverDay);
              },
            ),
            ListTile(
              leading: const Icon(
                CupertinoIcons.time,
                color: Colors.white,
                size: 32,
              ),
              title: const Text(
                'Attendance History',
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              onTap: (){
                Navigator.of(context).pop();
                toggleDrawerContent(TimeEntryTypeConstraints.entryHistory);
              },
            ),
          ],
        ),
      ),
    );
  }
}
