import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok/utils/validator.dart';
import 'package:tiktok/screens/main_page.dart';

/// Stateful widget to fetch and then display video content.
class AnswerPage extends StatefulWidget {
  const AnswerPage({Key? key, required this.question, required this.id})
      : super(key: key);
  final String question;
  final String id;

  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  final _formKey = GlobalKey<FormState>();
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String ctime = DateFormat("HH:mm:ss").format(DateTime.now());

  TextEditingController valueController = TextEditingController();
  final _focusAnswer = FocusNode();

  @override
  Widget build(BuildContext context) {
    CollectionReference Upload =
        FirebaseFirestore.instance.collection('Upload');

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            padding:
                new EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
            margin:
                new EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Color.fromARGB(255, 10, 215, 238),
            ),
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    margin: new EdgeInsets.only(
                        left: 50, right: 50, bottom: 20, top: 50),
                    child: new Text(
                      '${widget.question}',
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    margin:
                        new EdgeInsets.only(left: 50, right: 50, bottom: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            focusNode: _focusAnswer,
                            controller: valueController,
                            decoration: InputDecoration(
                              labelText: 'Enter Answer',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(fontSize: 25),
                            validator: (value) => Validator.validateAnswer(
                              answer: value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(valueController.text);
                          Upload.doc('${widget.id}')
                              .update(
                                  {"Answer": valueController.text.toString()})
                              .then((value) => print("User Updated"))
                              .catchError((error) =>
                                  print("Failed to update user: $error"));

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 124, 124, 124),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Upload.add({
        //       'Date': '20023',
        //       'Name': '1234',
        //       'Question': '1234',
        //       'Time': '23412'
        //     })
        //         .then((value) => print("User Added"))
        //         .catchError((error) => print("Failed to add user: $error"));
        //     Upload
        //       ..get().then((QuerySnapshot querySnapshot) {
        //         querySnapshot.docs.forEach((doc) {
        //           print(doc['Date']);
        //         });
        //       });
        //     setState(() {
        //       _controller.value.isPlaying
        //           ? _controller.pause()
        //           : _controller.play();
        //     });
        //   },
        //   child: Icon(
        //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //   ),
        // ),
      ),
    );
  }
}
