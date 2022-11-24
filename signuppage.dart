import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


import 'package:mylibrary/Auth/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController addressone = TextEditingController();
  final TextEditingController addresstwo = TextEditingController();
  final TextEditingController addressthree = TextEditingController();
  final TextEditingController addressfour = TextEditingController();
  final TextEditingController alias = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final RegExp phoneRegex = new RegExp(r'^[6-9]\d{9}$');


  @override
  void initState() {
    setState(() {

    });

    super.initState();
  }


  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xff113162)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: Color(0xff113162)),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "SignUp ",
            style: TextStyle(
              fontSize: 30,
              color: Color(0xff113162),
            ),
          ),
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Builder(builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add your Account",
                          style: TextStyle(
                            color: Color(
                              0xff113162,
                            ),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          labelText: 'Address One',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: addressone,
                        validator: (CurrentValue) {
                          var nonNullValue = CurrentValue ?? '';
                          if (nonNullValue.isEmpty) {
                            return ('Enter your address');
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          labelText: 'Address Two',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: addresstwo,
                        validator: (CurrentValue) {
                          var nonNullValue = CurrentValue ?? '';
                          if (nonNullValue.isEmpty) {
                            return ('Enter your address');
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          labelText: 'Address Three',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: addressthree,
                        validator: (CurrentValue) {
                          var nonNullValue = CurrentValue ?? '';
                          if (nonNullValue.isEmpty) {
                            return ('Enter your address');
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city),
                          labelText: 'Address Four',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: addressfour,
                        validator: (CurrentValue) {
                          var nonNullValue = CurrentValue ?? '';
                          if (nonNullValue.isEmpty) {
                            return ('Enter your address');
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Alias',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: alias,
                        validator: (CurrentValue) {
                          var nonNullValue = CurrentValue ?? '';
                          if (nonNullValue.isEmpty) {
                            return ('Enter your alias');
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Full Name',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: fullname,
                        validator: (CurrentValue) {
                          var nonNullValue = CurrentValue ?? '';
                          if (nonNullValue.isEmpty) {
                            return ('Enter your full name');
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(

                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password_outlined),

                        filled: true,
                        fillColor: Colors.white,
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
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Passwords must have upper and lower case letters,at least 1 number and special character,not match or contain email and be at least 5 characters long.")),

                    SizedBox(height: 10,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      controller: email,
                      validator: (CurrentValue) {
                        var nonNullValue = CurrentValue ?? '';
                        if (nonNullValue.isEmpty) {
                          return ("username is required");
                        }
                        if (!nonNullValue.contains("@")) {
                          return ("username should contains @");
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mobile_friendly),
                          hintText: "Mobile Number",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: _phoneNumberController,
                        validator: (CurrentValue) {
                          var nonNullValue = CurrentValue ?? '';
                          if (nonNullValue.isEmpty) {
                            return ("Mobile Number is required");
                          }
                          if (!phoneRegex.hasMatch(nonNullValue)) {
                            return 'Please enter valid phone number';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        child: Text(
                          "SignUp",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () async {

                          if (Form.of(context)?.validate() ?? false) {
                            createUser();
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Color(
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
                  ],
                );
              }),
            ),
          ),
        ));
  }

  createUser() async {

    print('----------------Signup API user called----------------');
    var apiUrl = "http://103.76.253.3/Grocery/Service1.svc/AddAccount";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({
        "Add1": addressone.text.trim().toString(),
        "Add2": addresstwo.text.trim().toString(),
        "Add3": addressthree.text.trim().toString(),
        "Add4": addressfour.text.trim().toString(),
        "Alias": alias.text.trim().toString(),
         "FullName": _phoneNumberController.text.trim().toString(),
        "Password":password.text.trim().toString(),
        "email":email.text.trim().toString(),
        "mobile": _phoneNumberController.text.trim().toString(),
      }),
    );
      print(response.body);
    if (json.decode(response.body)!=null) {
      Fluttertoast.showToast(
        msg: json.decode(response.body)["Result"], // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER, // location
        timeInSecForIosWeb: 1, // duration
      );
      print('success');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => LoginPage()));
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


}
