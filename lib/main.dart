import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppy/screens/SignUpScreen.dart';
import 'NavigationBarScreen.dart';
import 'styles/colors.dart';
import 'screens/ForgotPasswordScreen.dart';
import 'DataController.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
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
      LoaderDialog.showLoadingDialog(context, _LoaderDialog);
      await getAccountDataDB(userController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NavigationBarScreen()),
      );
    } else {
      _changed(true, "incorrect");
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (_) => const NavigationBarScreen()),
    // );
  }
}

class LoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    var wid = MediaQuery.of(context).size.width / 2;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Dialog(
              key: key,
              backgroundColor: Colors.transparent,
              child: SizedBox(
                width: 260.0,
                height: 260.0,
                child: Image.asset(
                  'asset/images/spinner.gif',
                  height: 260,
                  width: 260,
                ),
              )),
        );
      },
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
