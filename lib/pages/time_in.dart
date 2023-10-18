import 'package:contata_attendance/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeIn extends StatefulWidget {
  final Function(bool, String) onSubmit;

  const TimeIn({super.key, required this.onSubmit});

  @override
  State<TimeIn> createState() => _TimeInState();
}

class _TimeInState extends State<TimeIn> {
  final formKey = GlobalKey<FormState>();
  bool isTimeEntryDone = false;
  final String userKey = 'RB1507';
  String message = "";
  String informationText = "";
  String entryTimeIn = "";
  bool isButtonEnabled = true;
  bool isContainerVisible = false;
  bool isCrossOverDay = false;

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

  @override
  void dispose() {
    // Dispose of the TextEditingController when the widget is removed
    super.dispose();
  }

  Future<void> retrieveTimeEntry() async {
    final prefs = await SharedPreferences.getInstance();
    final isAlreadyTimein =
        prefs.getBool(TimeEntryTypeConstraints.timeIn) ?? false;
    final entryTime =
        prefs.getString(TimeEntryTypeConstraints.entryTimeIn) ?? "";
    final isCrossOver =
        prefs.getBool(TimeEntryTypeConstraints.crossOverDay) ?? false;
    setState(() {
      isButtonEnabled = !isAlreadyTimein;
      isContainerVisible = isAlreadyTimein;
      entryTimeIn = entryTime;
      informationText = "Your submitted time is: $entryTimeIn";
      isCrossOverDay = isCrossOver;
      if (isCrossOverDay) {
        isButtonEnabled = false;
        isContainerVisible = true;
        informationText = "Please submit your cross over day entry first!";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Call your async function when the page loads

    retrieveTimeEntry();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Column(
          children: [
            Container(
              width: 300,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.indigo[100],
                    child: Text(
                      'Time In',
                      style: TextStyle(
                          color: Colors.indigo[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: userKey,
                    enabled: false,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900 // Set the font size
                        // You can set other text-related properties here
                        ),
                    decoration:
                        const InputDecoration(labelText: 'Enter your key'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your key';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              if (!isTimeEntryDone) {
                                isButtonEnabled = false;
                                TimeEntry.saveTimeEntry(
                                    TimeEntryTypeConstraints.timeIn,
                                    TimeEntryTypeConstraints.entryTimeIn,
                                    TimeEntryTypeConstraints.entryTimeInDate);
                                widget.onSubmit(
                                    true, TimeEntryTypeConstraints.timeIn);
                                isTimeEntryDone = true;
                                showSnackbar(
                                    context,
                                    'Rahul! Welcome to Contata Solutions',
                                    true);
                              } else {
                                showSnackbar(
                                    context, 'Already submitted entry!', false);
                              }
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
                          'Submit',
                          style: TextStyle(
                              color: Colors.indigo[900], fontSize: 16),
                        ),
                        // Text
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: isContainerVisible,
              child: Container(
                width: 300, // Set the width as needed
                height: 70, // Set the height as needed
                decoration: const BoxDecoration(
                  color: Colors.blue, // Container background color
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)), // Set the border radius
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      informationText,
                      style: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
