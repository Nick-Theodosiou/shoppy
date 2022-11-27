import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppy/LoginScreen.dart';
import 'package:shoppy/NavigationBarScreen.dart';
import 'package:shoppy/screens/HomeScreen.dart';
import 'package:shoppy/screens/LoadingScreen.dart';

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
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = await prefs.getString('email')!;
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getId(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LoadingScreen(snapshot.data.toString());
          } else if (snapshot.hasError) {
            return LoginScreen(); //Error getting data
          } else {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/images/background_1.png"),
                    fit: BoxFit.cover),
              ),
              child: const Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ); //show Loading
          }
        },
      ),
    );
  }
}
