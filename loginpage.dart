//THIS PAGE IS USED TO LOGIN THE USER IN OUR APPLICATION

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylibrary/Home/menupage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  ///creating Username and Password Controller.
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          //To show exit popup
          child: WillPopScope(
            onWillPop: () => showExitPopup(context),
            child: Builder(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "My Library",
                    style: TextStyle(
                        color: Color(
                          0xff113162,
                        ),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.email),
                      labelStyle: TextStyle(fontSize: 20),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    controller: username,

                  ),
                  TextFormField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: new GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: new Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      prefixIcon: Icon(Icons.password_outlined),
                      labelStyle: TextStyle(fontSize: 20),
                      labelText: "password",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    controller: password,
                    validator: (PassCurrentValue) {
                      RegExp regex = RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      var passNonNullValue = PassCurrentValue ?? "";
                      if (passNonNullValue.isEmpty) {
                        return ("Password is required");
                      } else if (passNonNullValue.length < 6) {
                        return ("Password Must be more than 5 characters");
                      } else if (!regex.hasMatch(passNonNullValue)) {
                        return ("Password should contain upper,lower,digit and Special character ");
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        // if (Form.of(context)?.validate() ?? false) {
                          LoginUser();
                        // }
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(
                          0xff113162,
                        )),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
  LoginUser() async {
    print('Login user called');
    var apiUrl = "http://103.76.253.3/Grocery/Service1.svc/Login";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({
        "Name": username.text.trim().toString(),
        "Password": password.text.trim().toString(),
      }),
    );
print(response.body);
    if ( json.decode(response.body)["Result"]=="Success") {
      Fluttertoast.showToast(
        msg: json.decode(response.body)["Result"], // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER, // location
        timeInSecForIosWeb: 1, // duration
      );
      print('success');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return MenuPage();
        },
      ), (route) => false);
      Fluttertoast.showToast(
        msg: json.decode(response.body)["Result"], // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER, // location
        timeInSecForIosWeb: 1, // duration
      );
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MenuPage()));

    } else {
      Fluttertoast.showToast(
        msg: json.decode(response.body)["Result"], // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER, // location
        timeInSecForIosWeb: 1, // duration
      );
      print('error');
    }
  }
  //CODE FOR EXIT POPUP DIALOGUE

  showExitPopup(BuildContext context) {
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Do you want to exit?"),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('yes selected');
                      exit(0);
                    },
                    child: Text("Yes"),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.red.shade800),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    print('no selected');
                    Navigator.of(context).pop();
                  },
                  child: Text("No", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
