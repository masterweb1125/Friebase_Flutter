import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok/screens/code_page.dart';
import 'package:tiktok/screens/register_page.dart';
import 'package:tiktok/screens/change_page.dart';

import 'package:tiktok/utils/validator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ForgetPage extends StatelessWidget {
  ForgetPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _focusEmail = FocusNode();

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 179, 249, 247),
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
                    color: Color.fromARGB(255, 53, 133, 7),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                width: 400,
                height: 450,
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
                                      'Mot de Passe Oublie',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 178, 112, 7),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 35, right: 35, top: 60),
                                child: Column(children: <Widget>[
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
                                  SizedBox(
                                    height: 50,
                                    width: 400,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ChangePage(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromARGB(255, 246, 151, 88),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          )),
                                      child: Text(
                                        'Changez le mot de passe',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Creez un Compte',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 16, 16, 16),
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
              Stack(
                children: [
                  Center(
                      child: (Transform.translate(
                    offset: const Offset(0, 170),
                    child: ElevatedButton(
                      onPressed: () async {
                        _focusEmail.unfocus();
                        if (_formKey.currentState!.validate()) {
                          // resetPassword();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CodePage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 27, 107, 13),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Recevez le Code',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ))),
                  Center(
                    child: Transform.translate(
                      offset: const Offset(0, 210),
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
    );
  }

  Future resetPassword() async {
    try {
      print(';)');
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: "nana7fi@outlook.com");
    } on FirebaseAuthException catch (e) {
      print('I: ' + e.code);
    }
  }
}
