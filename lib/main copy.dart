import 'package:flutter/material.dart';
import 'NavigationBarScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  var username = "user";
  var password = "password";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("asset/images/background_1.png"), fit: BoxFit.fitWidth)),
          ),
          const Align(
            alignment: FractionalOffset(0.1, 0.65),
            child: Text(
                  "Log in",
                  style: TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: const FractionalOffset(0.5, 0.2),
            child: SizedBox(
              width: 200,
              height: 150,
              child: Image.asset('asset/images/logo.png')
            ),
          ),
          Align(
            alignment: const FractionalOffset(0.5, 0.7),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(

                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                TextButton(
                  onPressed: (){
                    showAlertDialog(context);
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => NavigationBarScreen()));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 130,
                ),
                const Text('New User? Create Account')
              ],
            ),
          ),
        ]
      ),
    );
  }
}

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: const Text("Yes daddy!"),
    onPressed: () => Navigator.pop(context, false),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Ποιος βλάκας ξεχάνει τον κωδικό του;"),
    content: const Text("Εσύ. Ναι εσύ."),
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