import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../main.dart';
import '../styles/colors.dart';
import 'SignUpScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //TextEditingController get userController => null;
    final userController = TextEditingController();
    
      bool visibilityIncorrect = false;

  void _changed(bool boolean, String field) {
    setState(() {
      if (field == "incorrect") {
        visibilityIncorrect = boolean;
      }
    });
  }
    void dispose() {
    // Clean up the controller when the widget is disposed.
    userController.dispose();
    super.dispose();
  }


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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight:FontWeight.bold 
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Enter your email and we'll send you a link\nto change your password",textAlign:TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                
                              ),
                            ),
                          ),
                           SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          textFormField('E-mail', userController),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          // visibilityIncorrect
                          //     ? const Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Text(
                          //           'Incorrect Email',
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //             fontSize: 12,
                          //           ),
                          //         ),
                          //       )
                          //     : Container(),
                          ElevatedButton(
                            onPressed: () {
                              //connect to database and send email for Change Password
                             Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginDemo()));
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(47),
                              backgroundColor: ShoppyColors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
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
                                          builder: (_) => const SignUp()));
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