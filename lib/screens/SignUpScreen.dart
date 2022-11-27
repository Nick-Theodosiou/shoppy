import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shoppy/LoginScreen.dart';
import '../NavigationBarScreen.dart';
import '../styles/colors.dart';
import 'ForgotPasswordScreen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var username = "user";
  var password = "password";
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
            child:SingleChildScrollView(
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
                      textFormField('Name'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textFormField('E-mail'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textFormField('Password'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      textFormField('Confirm Password'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NavigationBarScreen()),
                          );
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
                                      builder: (_) => const LoginScreen()));
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
                  )),
            ),
              ),
          ],
        ),
      ),
    );
  });
  }

  Tooltip textFormField(String textH) {
    bool hide = false;
    String tipMessage = '';
    // if(textH=='Password'|| textH=='Confirm Password') {
    //   hide = true;
    // }
    switch (textH) {
      case 'Name':
        {
          tipMessage = 'Enter your Name';
        }
        break;
      case 'E-mail':
        {
          tipMessage = 'Enter valid email id as abc@gamil.com';
        }
        break;
      case 'Password':
        {
          hide = true;
          tipMessage = 'Enter your Password';
        }
        break;
      case 'Confirm Password':
        {
          hide = true;
          tipMessage = 'Please enter the same Password as above';
        }
        break;
      default:
        {
          //statements;
        }
        break;
    }
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      //richMessage: ,
      //  showDuration: const Duration(milliseconds: 500),
      message: tipMessage,
      child: TextFormField(
        obscureText: hide,
        style: TextStyle(color: ShoppyColors.blue),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
          fillColor: const Color.fromARGB(240, 225, 225, 225),
          filled: true,
          hintStyle: TextStyle(color: ShoppyColors.blue),
          //  labelStyle: TextStyle(color:ShoppyColors.blue ),
          // labelText: textH,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: BorderSide(color: ShoppyColors.red)),
          hintText: textH,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () => Navigator.pop(context, false),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Question"),
    content: const Text("Description"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
