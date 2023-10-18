import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeEntryHistory extends StatefulWidget {
  const TimeEntryHistory({super.key});

  @override
  State<TimeEntryHistory> createState() => _TimeEntryHistoryState();
}

class _TimeEntryHistoryState extends State<TimeEntryHistory> {
// Retrieve user data
  String? user = '';

  Future<void> retrieveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username') ?? '';
    setState(() {
      user = savedUsername;
    });
  }

  @override
  void initState() {
    super.initState();
    // Call your async function when the page loads
    retrieveCredentials();
  }

  @override
  Widget build(BuildContext context) {
    //var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          'In/Out time details of: $user',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DataTable(
            border: TableBorder.all(width: 1),
            columnSpacing: 36,
            horizontalMargin: 13,
            columns: const [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('In Time')),
              DataColumn(label: Text('Out Time')),
              DataColumn(label: Text('Total hrs'))
            ],
            rows: const [
              DataRow(cells: [
                DataCell(Text('17/10/2023')),
                DataCell(Text('10:00 AM')),
                DataCell(Text('7:30 PM')),
                DataCell(Text('9:30')),
              ]),
              DataRow(cells: [
                DataCell(Text('16/10/2023')),
                DataCell(Text('10:00 AM')),
                DataCell(Text('7:30 PM')),
                DataCell(Text('9:30')),
              ]),
              DataRow(cells: [
                DataCell(Text('15/10/2023')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('weekend')),
              ]),
              DataRow(cells: [
                DataCell(Text('14/10/2023')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('weekend')),
              ]),
              DataRow(cells: [
                DataCell(Text('13/10/2023')),
                DataCell(Text('10:00 AM')),
                DataCell(Text('7:30 PM')),
                DataCell(Text('9:30')),
              ]),
              DataRow(cells: [
                DataCell(Text('12/10/2023')),
                DataCell(Text('10:00 AM')),
                DataCell(Text('7:30 PM')),
                DataCell(Text('9:30')),
              ]),
              DataRow(cells: [
                DataCell(Text('11/10/2023')),
                DataCell(Text('10:00 AM')),
                DataCell(Text('7:30 PM')),
                DataCell(Text('9:30')),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
