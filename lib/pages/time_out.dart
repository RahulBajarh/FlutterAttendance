import 'package:contata_attendance/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeOut extends StatefulWidget {
  final Function(bool, String) onSubmit;

  const TimeOut({super.key, required this.onSubmit});

  @override
  State<TimeOut> createState() => _TimeOutState();
}

class _TimeOutState extends State<TimeOut> {
  final formKey = GlobalKey<FormState>();
  bool isTimeEntryDone = false;
  final String userKey = 'RB1507';
  String message = "";
  bool isButtonEnabled = true;

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
        duration: const Duration(seconds: 3),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> saveTimeEntry(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('timeout', false);
  }

  @override
  void dispose() {
    // Dispose of the TextEditingController when the widget is removed
    super.dispose();
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
                child: Text(
                  'Time Out',
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              const SizedBox(height: 10),
              // Add space between header and input field
              TextFormField(
                  initialValue: userKey,
                  enabled: isButtonEnabled,
                  decoration:
                      const InputDecoration(labelText: 'Enter your key'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your key';
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
              // Add space between input field and button
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (!isTimeEntryDone) {
                      widget.onSubmit(true, TimeEntryTypeConstraints.timeOut);
                      isTimeEntryDone = true;
                      showSnackbar(
                          context,
                          'Rahul! Your Out Time Updated Successfully',
                          true);
                    } else {
                      showSnackbar(context, 'Already submitted entry!', false);
                    }
                  }
                },
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
                      'Submit',
                      style: TextStyle(
                        color: Colors.indigo[900], // Change the text color here
                      ),
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
