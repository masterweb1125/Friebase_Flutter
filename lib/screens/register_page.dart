import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok/screens/login_page.dart';
import 'package:tiktok/screens/main_page.dart';
import 'package:tiktok/utils/fire_auth.dart';
import 'package:tiktok/utils/validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _phoneTextController = TextEditingController();
  final _againpasswordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusPhone = FocusNode();
  final _focusAgainPassword = FocusNode();

  bool _isProcessing = false;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
        _focusPhone.unfocus();
        _focusAgainPassword.unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(top: 170, left: 30, right: 30, bottom: 0),
          child: Container(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                      width: 2.0,
                      color: Color.fromARGB(255, 255, 166, 0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  width: 400,
                  height: 450,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: _registerFormKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 103, 2),
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //apply padding to all four sides
                                          margin: EdgeInsets.only(
                                              left:
                                                  30 // space between underline and text
                                              ),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: Color.fromARGB(255, 0, 103,
                                                2), // Text colour here
                                            width: 1.0, // Underline width
                                          ))),
                                          child: Text(
                                            'Enregistrement',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 0, 103, 2),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 35,
                                      right: 35,
                                      top: 20,
                                    ),
                                    child: Column(children: <Widget>[
                                      TextFormField(
                                        controller: _phoneTextController,
                                        focusNode: _focusPhone,
                                        validator: (value) =>
                                            Validator.validatePhone(
                                          phone: value,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Numero de telephone",
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
                                                color: Color.fromARGB(
                                                    255, 50, 51, 50),
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
                                      SizedBox(height: 16.0),
                                      TextFormField(
                                        controller: _emailTextController,
                                        focusNode: _focusEmail,
                                        validator: (value) =>
                                            Validator.validateEmail(
                                          email: value,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Email",
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
                                                color: Color.fromARGB(
                                                    255, 50, 51, 50),
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
                                      SizedBox(height: 16.0),
                                      TextFormField(
                                        controller: _nameTextController,
                                        focusNode: _focusName,
                                        validator: (value) =>
                                            Validator.validateName(
                                          name: value,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Utilisateur",
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
                                                color: Color.fromARGB(
                                                    255, 50, 51, 50),
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
                                      SizedBox(height: 16.0),
                                      TextFormField(
                                        controller: _passwordTextController,
                                        focusNode: _focusPassword,
                                        obscureText: true,
                                        validator: (value) =>
                                            Validator.validatePassword(
                                          password: value,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Mot de passe",
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
                                                color: Color.fromARGB(
                                                    255, 50, 51, 50),
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
                                      SizedBox(height: 16.0),
                                      TextFormField(
                                        controller:
                                            _againpasswordTextController,
                                        focusNode: _focusAgainPassword,
                                        obscureText: true,
                                        validator: (val) {
                                          if (val!.isEmpty) return 'Empty';
                                          if (val !=
                                              _passwordTextController.text)
                                            return 'Not match';
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "saisir à nouveau",
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
                                                color: Color.fromARGB(
                                                    255, 50, 51, 50),
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
                                      SizedBox(height: 16.0),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'déjà utilisateur',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 117, 117, 117),
                                              fontSize: 15),
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
                ),
                _isProcessing
                    ? Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
                          Center(
                              child: (Transform.translate(
                            offset: const Offset(0, 170),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_registerFormKey.currentState!.validate()) {
                                  setState(() {
                                    _isProcessing = true;
                                  });

                                  Object userInfo = {
                                    "name": _nameTextController.text,
                                    "phone": _phoneTextController.text
                                  };
                                  String stringUserInfo = jsonEncode(userInfo);
                                  User? user =
                                      await FireAuth.registerUsingEmailPassword(
                                    name: stringUserInfo,
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                  );

                                  if (user != null) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            // ProfilePage(user: user),
                                            MainPage(),
                                      ),
                                      ModalRoute.withName('/'),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 209, 6),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Inscription',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ))),
                          Center(
                            child: Transform.translate(
                              offset: const Offset(0, 210),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
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
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  bottom: 10,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  onPressed: () => {signInWithGoogle()},
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://icon2.cleanpng.com/20180423/rjw/kisspng-google-logo-logo-logo-5ade7dc7134299.2873015115245306310789.jpg'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 40,
                  bottom: 10,
                ),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://flyclipart.com/thumb2/facebook-icon-transparent-background-round-744263.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 40,
                  bottom: 10,
                ),
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://asgsr.org/wp-content/uploads/2020/08/409-4097837_transparent-background-twitter-logo-hd-png-download.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
