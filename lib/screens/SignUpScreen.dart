import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/LoginScreen.dart';
import 'package:shoppy/screens/LoadingScreen.dart';
import '../styles/colors.dart';
import 'package:crypto/crypto.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passController = TextEditingController();
  final confpassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    nameController.dispose();
    surnameController.dispose();
    passController.dispose();
    confpassController.dispose();
    super.dispose();
  }

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
                              ? MediaQuery.of(context).size.height * 0.08
                              : 0,
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.20,
                            // ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Sign Up',
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
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                } else if (value.codeUnits
                                    .any((element) => element > 128)) {
                                  return 'Please use Latin characters';
                                }
                                return null;
                              },
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
                                //  labelStyle: TextStyle(color:ShoppyColors.blue ),
                                // labelText: textH,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide:
                                        BorderSide(color: ShoppyColors.red)),
                                hintText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormField(
                              controller: surnameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your surname';
                                } else if (value.codeUnits
                                    .any((element) => element > 128)) {
                                  return 'Please use Latin characters';
                                }
                                return null;
                              },
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
                                //  labelStyle: TextStyle(color:ShoppyColors.blue ),
                                // labelText: textH,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide:
                                        BorderSide(color: ShoppyColors.red)),
                                hintText: "Surname",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!value.contains('@') ||
                                    !value.contains('.')) {
                                  return 'This is not a valid email address';
                                } else if (value.codeUnits
                                    .any((element) => element > 128)) {
                                  return 'Please use Latin characters';
                                }
                                return null;
                              },
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
                                //  labelStyle: TextStyle(color:ShoppyColors.blue ),
                                // labelText: textH,
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
                              controller: passController,
                              validator: (value) {
                                RegExp regex = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (!regex.hasMatch(value)) {
                                  return 'This is not a valid password. Please use:\nMinimum 1 Uppercase character\nMinimum 1 Lowercase character\nMinimum 1 Numeric character\nMinimum 1 Special Character\nMust be at least 8 characters in length';
                                } else if (value.codeUnits
                                    .any((element) => element > 128)) {
                                  return 'Please use Latin characters';
                                }
                                return null;
                              },
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
                                //  labelStyle: TextStyle(color:ShoppyColors.blue ),
                                // labelText: textH,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide:
                                        BorderSide(color: ShoppyColors.red)),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormField(
                              controller: confpassController,
                              validator: (value) {
                                RegExp regex = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value.toString() !=
                                    passController.text) {
                                  return 'Passwords do not match';
                                } else if (value.codeUnits
                                    .any((element) => element > 128)) {
                                  return 'Please use Latin characters';
                                }
                                return null;
                              },
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
                                //  labelStyle: TextStyle(color:ShoppyColors.blue ),
                                // labelText: textH,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide:
                                        BorderSide(color: ShoppyColors.red)),
                                hintText: "Confirm password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35)),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  signup();
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
                                'Sign Up',
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
                                  "Already have an account ?",
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
                                                const LoginScreen()));
                                  },
                                  child: Text(
                                    'Log in',
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

  void signup() async {
    var bytes1 = utf8.encode(passController.text);         
    var digest1 = sha256.convert(bytes1);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing your data.')),
    );
    if (await signUp(emailController.text, nameController.text,
        surnameController.text, digest1.toString())) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Account created successfully. Redirecting you to Shoppy home page.')),
      );
      String email = emailController.text;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoadingScreen(email)),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'An error occured. Please try signing up with a different email. If the error persists, please contact our support team.')),
      );
    }
  }
}
