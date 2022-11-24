import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:mylibrary/Auth/loginpage.dart';
import 'package:mylibrary/Auth/signuppage.dart';

void main() async {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    splashScreen();
    super.initState();
  }

  splashScreen() async {
    Timer(Duration(seconds: 3),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff113162),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "My Library",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "When in doubt go to the library",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Loading",style: TextStyle(color: Colors.white, fontSize: 20)),
                  JumpingDots(
                    radius: 5.0,
                    color: Colors.white,
                    numberOfDots: 6,
                    innerPadding: 3,

                    animationDuration: Duration(seconds: 3),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
