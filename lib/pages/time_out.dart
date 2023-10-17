import 'package:contata_attendance/utils/common.dart';
import 'package:flutter/material.dart';

class TimeOut extends StatefulWidget {
  final Function(bool, String) onSubmit;

  const TimeOut({super.key, required this.onSubmit});

  @override
  State<TimeOut> createState() => _TimeOutState();
}

class _TimeOutState extends State<TimeOut> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  bool isTimeEntryDone = false;
  String userKey = '';
  String message = "";

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

  @override
  void dispose() {
    // Dispose of the TextEditingController when the widget is removed
    _textController.dispose();
    super.dispose();
  }

  void clearTextField() {
    setState(() {
      _textController.clear(); // Clear the text field
      userKey = ""; // Reset the text value
    });
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
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Enter your key'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your key';
                  }
                  return null;
                },
                onSaved: (value) {
                  userKey = value!;
                },
              ),
              const SizedBox(height: 10),
              // Add space between input field and button
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (!isTimeEntryDone) {
                      clearTextField();
                      widget.onSubmit(true, TimeEntryTypeConstraints.timeOut);
                      isTimeEntryDone = true;
                      showSnackbar(
                          context,
                          'Rahul! Your Time Out Entry Updated Successfully',
                          true);
                    } else {
                      clearTextField();
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
