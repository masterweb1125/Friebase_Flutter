import 'package:flutter/material.dart';
import 'package:tiktok/screens/login_page.dart';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok/screens/main_page.dart';
import 'package:tiktok/screens/register_page.dart';
import 'package:tiktok/utils/fire_auth.dart';
import 'package:tiktok/utils/validator.dart';

class ChangePage extends StatelessWidget {
  ChangePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _passwordTextController = TextEditingController();
  final _againpasswordTextController = TextEditingController();

  final _focusPassword = FocusNode();
  final _focusAgainPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 179, 249, 247),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 200, left: 30, right: 30, bottom: 0),
        child: Container(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                    width: 2.0,
                    color: Color.fromARGB(255, 53, 133, 7),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                width: 400,
                height: 500,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(30, 0, 30, 50),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      top:
                                          20), //apply padding to all four sides
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom:
                                          8, // space between underline and text
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                      color: Color.fromARGB(
                                          255, 178, 112, 7), // Text colour here
                                      width: 2.0, // Underline width
                                    ))),
                                    child: Text(
                                      'Changez Votre Mot de Passe',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 178, 112, 7),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 35, right: 35, top: 80),
                                child: Column(children: <Widget>[
                                  TextFormField(
                                    controller: _passwordTextController,
                                    focusNode: _focusPassword,
                                    obscureText: true,
                                    validator: (value) =>
                                        Validator.validatePassword(
                                      password: value,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Nouveau mot de passe",
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 30),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 62, 15, 182),
                                            width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 50, 51, 50),
                                            width: 1.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  TextFormField(
                                    controller: _againpasswordTextController,
                                    focusNode: _focusAgainPassword,
                                    obscureText: true,
                                    validator: (val) {
                                      if (val!.isEmpty) return 'Empty';
                                      if (val != _passwordTextController.text) {
                                        return 'Not match';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "saisir à nouveau",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 30),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 62, 15, 182),
                                            width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 50, 51, 50),
                                            width: 1.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        width: 1.0,
                                        color:
                                            Color.fromARGB(255, 154, 150, 150),
                                      ),
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    child: Text(
                                      'Home',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 83, 81, 81),
                                          fontSize: 20),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Center(
                      child: (Transform.translate(
                    offset: const Offset(0, 205),
                    child: ElevatedButton(
                      onPressed: () async {
                        _focusPassword.unfocus();
                        _focusAgainPassword.unfocus();
                        if (_formKey.currentState!.validate()) {}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 27, 107, 13),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Changez le Mot de Passe',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ))),
                  Center(
                    child: Transform.translate(
                      offset: const Offset(0, 260),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 186, 183, 181),
                            ),
                            child: const Text(
                              'Prev',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 186, 183, 181),
                            ),
                            child: Text(
                              'Next',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
