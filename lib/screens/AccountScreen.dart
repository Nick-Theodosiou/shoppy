import 'package:flutter/material.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/main.dart';
import 'package:shoppy/styles/colors.dart';
import '../models/User.dart';
import 'ForgotPasswordScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _AccountScreenState extends State<AccountScreen> {
  // User user = localUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.circle,
                      size: 170,
                      color: Color.fromARGB(53, 190, 190, 190),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Icon(
                        Icons.person_outline,
                        size: 80,
                        color: ShoppyColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 60,
                top: 100,
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Name",
                        style: TextStyle(fontSize: 10, height: 0.6)),
                  ),
                  Stack(
                    children: [
                      TextFormField(
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          decoration: const InputDecoration(
                              hintText: 'Constantinos',
                              hintStyle:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          textAlign: TextAlign.left),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.edit,
                            size: 25,
                            color: ShoppyColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Surname",
                        style: TextStyle(fontSize: 10, height: 0.6)),
                  ),
                  Stack(
                    children: [
                      TextFormField(
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          decoration: const InputDecoration(
                              hintText: 'Paphitis',
                              hintStyle:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          textAlign: TextAlign.left),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.edit,
                            size: 25,
                            color: ShoppyColors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     AlwaysDisabledFocusNode.flag =
                  //         !(AlwaysDisabledFocusNode.flag);
                  //   },
                  //   child: const Text(
                  //     'Log In',
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("E-mail",
                        style: TextStyle(fontSize: 10, height: 0.6)),
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'paphitis@yahoo.com',
                          hintStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      enableInteractiveSelection: false,
                      focusNode: AlwaysDisabledFocusNode(),
                      textAlign: TextAlign.left),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Do you want to change password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: ShoppyColors.blue,
                          decorationThickness: 1.8,
                          color: ShoppyColors.blue,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(47),
                        backgroundColor: ShoppyColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text("Refresh"),
                    onPressed: () {
                      // getAccountDataDB(user.email);
                      // setState(() {
                      //   user = localUser;
                      // });
                    },
                  ),

                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        softWrap: true,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Log Out ",
                                style: TextStyle(
                                    fontSize: 25, color: ShoppyColors.red)),
                            WidgetSpan(
                              child: Icon(
                                Icons.logout_outlined,
                                size: 25,
                                color: ShoppyColors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onPressed: () {
                      // localUser = null;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MyApp()),
                      );
                    },
                  ),
                ],
              ), //
            ),
          ],
        ),
      ),
    );
  }
}
