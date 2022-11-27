import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppy/LoadingScreen.dart';
import 'package:shoppy/screens/SignUpScreen.dart';
import 'NavigationBarScreen.dart';
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
                          textFormField('E-mail', userController),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          textFormField('Password', passController),
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
                          visibilityIncorrect
                              ? const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Incorrect Username and Password',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              : Container(),
                          ElevatedButton(
                            onPressed: () {
                              login();
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
                                          builder: (_) => const SignUpScreen()));
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
                      )),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  TextFormField textFormField(String textH, TextEditingController eController) {
    bool hide = false;
    if (textH == 'Password') {
      hide = true;
    }
    return TextFormField(
      controller: eController,
      obscureText: hide,
      style: TextStyle(color: ShoppyColors.blue),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
        fillColor: const Color.fromARGB(240, 225, 225, 225),
        filled: true,
        hintStyle: TextStyle(color: ShoppyColors.blue),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: ShoppyColors.red)),
        hintText: textH,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
      ),
    );
  }

  Future<void> login() async {
    if (await checkCredentials(userController.text, passController.text)) {
      final GlobalKey<State> _LoaderDialog = new GlobalKey<State>();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoadingScreen(userController.text)),
      );
    } else {
      _changed(true, "incorrect");
    }
  }
}
