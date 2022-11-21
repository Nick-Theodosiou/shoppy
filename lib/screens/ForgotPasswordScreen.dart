import 'package:flutter/material.dart';

import '../styles/colors.dart';
import 'SignUpScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration:  BoxDecoration(
        color:ShoppyColors.blue,
        image: const DecorationImage(
            image: AssetImage("asset/images/logo.png",) ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          
                  body:    Row(
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
                              )
                    ],
                  )
                  ));
}
}
