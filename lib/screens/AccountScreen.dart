import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/LoginScreen.dart';
import 'package:shoppy/screens/ForgotPasswordScreenInternal.dart';
import 'package:shoppy/styles/colors.dart';
import '../models/User.dart';

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
  bool _notificationsEnabled = true;

  void _updateNotifications(bool notifications) {
    _notificationsEnabled = notifications;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController surname = TextEditingController();

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Icon(
                        Icons.circle,
                        size: 150,
                        color: Color.fromARGB(53, 190, 190, 190),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 35.0),
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
                  top: 30,
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Name",
                          style: TextStyle(
                              fontSize: 10, height: 0.5, color: Colors.grey)),
                    ),
                    Stack(
                      children: [
                        TextFormField(
                            controller: name,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                                hintText: localUser.name,
                                hintStyle: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Surname",
                          style: TextStyle(
                              fontSize: 10, height: 0.5, color: Colors.grey)),
                    ),
                    Stack(
                      children: [
                        TextFormField(
                            controller: surname,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                                hintText: localUser.surname,
                                hintStyle: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("E-mail",
                          style: TextStyle(
                              fontSize: 10, height: 0.5, color: Colors.grey)),
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            hintText: localUser.email,
                            hintStyle: const TextStyle(
                                fontSize: 20, color: Colors.black)),
                        enableInteractiveSelection: false,
                        focusNode: AlwaysDisabledFocusNode(),
                        textAlign: TextAlign.left),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        child: Text(
                          'Do you want to change password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: ShoppyColors.blue,
                            decorationThickness: 1.8,
                            color: ShoppyColors.blue,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ForgotPasswordScreenInternal()),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (name.text != '' && surname.text != '') {
                          updateUserDetails(name.text, surname.text);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('User details successfuly changed.')),
                          );
                        } else if (name.text != '') {
                          updateUserDetails(name.text, localUser.surname);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('User name successfuly changed.')),
                          );
                        } else if (surname.text != '') {
                          updateUserDetails(localUser.name, surname.text);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('User surname successfuly changed.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(47),
                        backgroundColor: ShoppyColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notifications',
                          style:
                              TextStyle(fontSize: 20, color: ShoppyColors.blue),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                              value: _notificationsEnabled,
                              activeColor: ShoppyColors.blue,
                              onChanged: (value) {
                                setState(() {
                                  _notificationsEnabled =
                                      !_notificationsEnabled;
                                  _updateNotifications(value);
                                });
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              softWrap: true,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Log Out ",
                                    style: TextStyle(
                                        fontSize: 25, color: ShoppyColors.red),
                                  ),
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
                          onPressed: () async {
                            localUser = User(
                                -1, "name", "surname", "email", [], [], []);
                            final prefs = await SharedPreferences.getInstance();
                            final success = await prefs.remove('email');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ), //
              ),
            ],
          ),
        ),
      ),
    );
  }
}
