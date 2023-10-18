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
  final TextStyle myTableHeaderTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
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
        Column(
          children: [
            Container(
              width: 300, // Set the width as needed
              height: 70, // Set the height as needed
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                // Container background color
                borderRadius: const BorderRadius.all(
                    Radius.circular(10)), // Set the border radius
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'In/Out time details of: ',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        'Rahul Bazad',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DataTable(
            border: TableBorder.all(width: 2),
            columnSpacing: 36,
            horizontalMargin: 13,
            // Adjust the height of data rows as needed
            headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
              return Colors.grey.withOpacity(0.6); // Set the header background color
            }),
            columns: [
              DataColumn(label: Text('Date',style: myTableHeaderTextStyle,)),
              DataColumn(label: Text('In Time',style: myTableHeaderTextStyle,)),
              DataColumn(label: Text('Out Time',style: myTableHeaderTextStyle,)),
              DataColumn(label: Text('Total hrs',style: myTableHeaderTextStyle,))
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
