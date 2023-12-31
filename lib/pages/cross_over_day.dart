import 'dart:async';

import 'package:contata_attendance/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrossOverDay extends StatefulWidget {
  final Function(bool, String) onSubmit;

  const CrossOverDay({super.key, required this.onSubmit});

  @override
  State<CrossOverDay> createState() => _CrossOverDayState();
}

class _CrossOverDayState extends State<CrossOverDay> {
  final formKey = GlobalKey<FormState>();
  bool isTimeEntryDone = false;
  final String userKey = 'RB1507';
  String message = "";
  bool isButtonEnabled = false;
  bool isContainerVisible = false;
  Timer? myTimer;

  void showSnackbar(BuildContext context, String newMessage, bool isSuccess) {
    setState(() {
      message = newMessage;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white, // Change text color
            fontSize: 18, // Change text size
          ),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> saveTimeEntry(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('crossoverday', true);
  }

  @override
  void dispose() {
    // Dispose of the TextEditingController when the widget is removed
    super.dispose();
    //clearStoredDataNextDay();
  }

  Future<void> retrieveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final isCrossOver =
        prefs.getBool(TimeEntryTypeConstraints.crossOverDay) ?? false;
    setState(() {
      isButtonEnabled = isCrossOver;
    });
  }

  @override
  void initState() {
    super.initState();
    // Call your async function when the page loads

    retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.indigo[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time Out',
                      style: TextStyle(
                          color: Colors.indigo[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      '(Cross Over Day)',
                      style: TextStyle(
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Add space between header and input field
              TextFormField(
                initialValue: userKey,
                enabled: false,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900 // Set the font size
                    // You can set other text-related properties here
                    ),
                decoration: const InputDecoration(labelText: 'Enter your key'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your key';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // Add space between input field and button
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          isButtonEnabled = false;
                          TimeEntry.saveUserDetails(false);
                          widget.onSubmit(
                              true, TimeEntryTypeConstraints.crossOverDay);
                          isTimeEntryDone = true;
                          showSnackbar(
                              context,
                              'Rahul! Your Cross Over Day Updated Successfully',
                              true);
                        }
                      }
                    : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.timer,
                      color: Colors.indigo,
                    ),
                    // Icon
                    const SizedBox(width: 8),
                    // Add space between the icon and text
                    Text(
                      'COD Submit',
                      style: TextStyle(color: Colors.indigo[900], fontSize: 16),
                    ),
                    // Text
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
