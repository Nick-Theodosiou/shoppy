import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/screens/LoadingScreen.dart';
import 'package:shoppy/screens/SignUpScreen.dart';
import 'styles/colors.dart';
import 'screens/ForgotPasswordScreen.dart';
import 'DataController.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visibilityIncorrect = false;

  void _changed(bool boolean, String field) {
    setState(() {
      if (field == "incorrect") {
        visibilityIncorrect = boolean;
      }
    });
  }

  final userController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  var username = "user";
  var password = "password";

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/images/background_1.png"),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              isKeyboardVisible
                  ? Container()
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        padding: EdgeInsets.only(
                            top: isKeyboardVisible
                                ? 0
                                : MediaQuery.of(context).size.height * 0.25,
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1),
                        child: Image(
                          image: const AssetImage('asset/images/logo.png'),
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(
                  top: isKeyboardVisible
                      ? 0
                      : MediaQuery.of(context).size.height * 0.4,
                ),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                      padding: EdgeInsets.only(
                          top: isKeyboardVisible
                              ? MediaQuery.of(context).size.height * 0.25
                              : MediaQuery.of(context).size.height * 0.15,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!value.toString().contains('@')) {
                                  return 'This is not a valid email address';
                                }
                                return null;
                              },
                              controller: userController,
                              obscureText: false,
                              style: TextStyle(color: ShoppyColors.blue),
                              decoration: InputDecoration(
                                errorStyle:
                                    const TextStyle(color: Colors.white),
                                contentPadding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15),
                                fillColor:
                                    const Color.fromARGB(240, 225, 225, 225),
                                filled: true,
                                hintStyle: TextStyle(color: ShoppyColors.blue),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide:
                                        BorderSide(color: ShoppyColors.red)),
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              controller: passController,
                              obscureText: true,
                              style: TextStyle(color: ShoppyColors.blue),
                              decoration: InputDecoration(
                                errorStyle:
                                    const TextStyle(color: Colors.white),
                                contentPadding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15),
                                fillColor:
                                    const Color.fromARGB(240, 225, 225, 225),
                                filled: true,
                                hintStyle: TextStyle(color: ShoppyColors.blue),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide:
                                        BorderSide(color: ShoppyColors.red)),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ForgotPasswordScreen()));
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    decorationThickness: 1.8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            // visibilityIncorrect
                            //     ? const Align(
                            //         alignment: Alignment.center,
                            //         child: Text(
                            //           'Incorrect Username and Password',
                            //           style: TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 12,
                            //           ),
                            //         ),
                            //       )
                            //     : Container(),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  login();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(47),
                                backgroundColor: ShoppyColors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const SignUpScreen()));
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: ShoppyColors.red,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> login() async {
    var bytes1 = utf8.encode(passController.text);
    var digest1 = sha256.convert(bytes1);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );
    if (await checkCredentials(userController.text, digest1.toString())) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Correct login details. Fetching your data...')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoadingScreen(userController.text)),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Incorrect Email and/or Password. Please try again.')),
      );
    }
  }
}
