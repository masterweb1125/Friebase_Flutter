import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/screens/main_page.dart';
import 'package:tiktok/screens/forget_page.dart';
import 'package:tiktok/screens/register_page.dart';
import 'package:tiktok/utils/fire_auth.dart';
import 'package:tiktok/utils/validator.dart';
import 'package:tiktok/firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  final String apiKey = '123456';
  final String apiSecretKey = '123456';

  Future loginV2() async {
    final twitterLogin = TwitterLogin(
      /// Consumer API keys
      apiKey: apiKey,

      /// Consumer API Secret keys
      apiSecretKey: apiSecretKey,

      /// Registered Callback URLs in TwitterApp
      /// Android is a deeplink
      /// iOS is a URLScheme
      redirectURI: 'https://twitter.com/',
    );

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);
    final authResult = await twitterLogin.loginV2();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // success
        print('====== Login success ======');
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        print('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
      case null:
        // error
        print('====== Login error ======');
        break;
    }
  }

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

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    User? user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => MainPage(),
    //     ),
    //   );
    // }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(150, 221, 111, 1),
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    border: Border.all(
                      color: Color.fromARGB(255, 255, 166, 0),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 200.0, bottom: 20),
                  width: 400,
                  height: 480,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    color: Color.fromARGB(
                                        255, 0, 103, 2), // Text colour here
                                    width: 1.0, // Underline width
                                  ))),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 103, 2),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Enregistrement',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 103, 2),
                                        fontSize: 20),
                                  ),
                                ),
                              ]),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 80.0),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: TextFormField(
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
                                ),
                                SizedBox(height: 20.0),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: TextFormField(
                                    controller: _passwordTextController,
                                    focusNode: _focusPassword,
                                    obscureText: true,
                                    validator: (value) =>
                                        Validator.validatePassword(
                                      password: value,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Password",
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
                                ),
                                SizedBox(height: 24.0),
                                _isProcessing
                                    ? CircularProgressIndicator()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgetPage(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Login outlie",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 37, 36, 36),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              _focusEmail.unfocus();
                                              _focusPassword.unfocus();

                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  _isProcessing = true;
                                                });

                                                User? user = await FireAuth
                                                    .signInUsingEmailPassword(
                                                  email:
                                                      _emailTextController.text,
                                                  password:
                                                      _passwordTextController
                                                          .text,
                                                );

                                                setState(() {
                                                  _isProcessing = false;
                                                });

                                                if (user != null) {
                                                  user.sendEmailVerification();
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MainPage(),
                                                    ),
                                                  );
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: StadiumBorder(),
                                              backgroundColor: Color.fromARGB(
                                                  255, 255, 175, 3),
                                            ),
                                            child: Text(
                                              'Connexion',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
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
                  bottom: 30,
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
                  bottom: 30,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  onPressed: () => {signInWithFacebook()},
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://flyclipart.com/thumb2/facebook-icon-transparent-background-round-744263.png'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 40,
                  bottom: 30,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  onPressed: () async {
                    await loginV2();
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://asgsr.org/wp-content/uploads/2020/08/409-4097837_transparent-background-twitter-logo-hd-png-download.png'),
                    ),
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
