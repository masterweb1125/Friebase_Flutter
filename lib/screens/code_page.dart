import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:tiktok/screens/forget_page.dart';

class CodePage extends StatefulWidget {
  const CodePage({super.key});

  @override
  State<CodePage> createState() => _CodePage();
}

class _CodePage extends State<CodePage> {
  bool _onEditing = true;
  String? _code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                    color: Color.fromARGB(255, 184, 131, 6),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                width: 400,
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.only(
                              bottom: 3, // space between underline and text
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Color.fromARGB(
                                  255, 237, 193, 16), // Text colour here
                              width: 1.0, // Underline width
                            ))),
                            child: Text(
                              'Entrez le code',
                              style: TextStyle(
                                color: Color.fromARGB(255, 237, 193, 16),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Center(
                          child: Container(),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Column(
                          children: [
                            VerificationCode(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                              keyboardType: TextInputType.number,
                              underlineColor: Colors
                                  .amber, // If this is null it will use primaryColor: Colors.red from Theme
                              length: 4,
                              cursorColor: Color.fromARGB(255, 184, 197,
                                  0), // If this is null it will default to the ambient
                              // clearAll is NOT required, you can delete it
                              // takes any widget, so you can implement your design
                              clearAll: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'clear all',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      decoration: TextDecoration.underline,
                                      color: Color.fromARGB(255, 210, 102, 25)),
                                ),
                              ),
                              margin: const EdgeInsets.all(12),
                              onCompleted: (String value) {
                                setState(() {
                                  _code = value;
                                });
                              },
                              onEditing: (bool value) {
                                setState(() {
                                  _onEditing = value;
                                });
                                if (!_onEditing)
                                  FocusScope.of(context).unfocus();
                              },
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Center(
                            //     child: _onEditing
                            //         ? const Text('Please enter full code')
                            //         : Text('Your code: $_code'),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Container(
                            child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ForgetPage(),
                              ),
                            );
                          },
                          child: Text(
                            "renvoyez le Code",
                            style: TextStyle(
                              color: Color.fromARGB(255, 37, 36, 36),
                              fontSize: 15,
                            ),
                          ),
                        )),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 255, 255, 255)),
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Center(
                      child: (Transform.translate(
                    offset: const Offset(0, 205),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 174, 0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Verifiez le Code',
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
