import 'dart:async';
import 'dart:convert';

import 'package:contata_attendance/utils/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:contata_attendance/utils/routes.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool isLoggedIn = false;

  Future<void> handleLogin(String username, String password) async {
    isLoggedIn = true;
    saveCredentials(username);
    if (isLoggedIn) {
      Navigator.pushNamed(context, MyRoutes.homeRoute);
    }
  }

  Future<void> saveCredentials(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LoginKeys.username, username);
    await prefs.setBool(LoginKeys.keylogin, true);
  }

  Future<void> testLogin(String username, String password) async {
    try {
      Response response = await get(
        Uri.parse(
            'https://jsonplaceholder.typicode.com/users?username=$username'),
      );
      if (response.statusCode == 200) {
        final doc = response.body.toString();
        final userJSON = jsonDecode(doc);
        var userEmail = userJSON[0]['email'];
        if (userEmail != "") {
          saveCredentials(username);
          if (!context.mounted) {
            return;
          }
          Navigator.pushNamed(context, MyRoutes.homeRoute);
        } else {
          showSnackbar();
        }
      } else {
        showSnackbar();
      }
    } catch (e) {
      showSnackbar();
    }
  }

  Future<List<Map<String, dynamic>>?> fetchUsers() async {
    Response response = await get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      //throw Exception('Failed to load posts');
      showSnackbar();
      return null;
    }
  }

  void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Authentication failed. Please try again.',
          style: TextStyle(
            color: Colors.white, // Change text color
            fontSize: 18, // Change text size
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xffef4c25),
        title: const Text(
          'Login Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Image.asset("assets/images/login.png",
                      height: 250, width: 250, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Enter UserName",
                        labelText: "UserName",
                      ),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username is required!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required!';
                        } else if (value.length < 4) {
                          return 'Password length should be atleast 4!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await handleLogin(username, password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffef4c25),
                        minimumSize: const Size(150, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        List<Map<String, dynamic>>? posts = await fetchUsers();
                        // Handle the fetched posts
                        if (kDebugMode) {
                          print(posts);
                        }
                      },
                      child: const Text('Fetch Users'),
                    ),
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
