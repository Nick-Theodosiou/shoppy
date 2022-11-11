import 'package:flutter/material.dart';
import 'package:shoppy/main.dart';
import '../NavigationBarScreen.dart';
import '../styles/colors.dart';
import 'ForgotPasswordScreen.dart';

// void main() {
//   runApp(const SignUp());
// }

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpDemo(),
    );
  }
}

class SignUpDemo extends StatefulWidget {
  const SignUpDemo({super.key});

  @override
  _SignUpDemoState createState() => _SignUpDemoState();
}

class _SignUpDemoState extends State<SignUpDemo> {
  var username = "user";
  var password = "password";
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("asset/images/background_1.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25,
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: Image(
                  image: const AssetImage('asset/images/logo.png'),
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.32,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.20,
                      ),
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
                                      builder: (_) => const LoginDemo()));
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
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
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
