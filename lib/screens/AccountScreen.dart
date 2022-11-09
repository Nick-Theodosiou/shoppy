import 'package:flutter/material.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/styles/colors.dart';
import '../models/User.dart';
import 'ForgotPasswordScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  static User user = localUser;
  String email = user.email;
  String name = user.name;
  String surname = user.surname;

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
            Column(
              children: [
                Text(email),
                Text(name),
                Text(surname),
              ],
            ),
            TextButton(
              child: Text("Refresh"),
              onPressed: () {
                setState(() {
                  email = "Changed text. So refresh button works just fine.";
                  name = "This works too.";
                  surname = "Yeah OK we get it... It works";
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
