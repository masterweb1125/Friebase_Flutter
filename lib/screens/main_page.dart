import 'package:flutter/material.dart';
import 'package:tiktok/screens/login_page.dart';
import 'package:tiktok/screens/video_page.dart';
import 'package:tiktok/screens/answer_page.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference Upload =
        FirebaseFirestore.instance.collection('Upload');

    final sb = StringBuffer();
    sb.write(DateFormat("yyyy-MM-dd").format(DateTime.now()).toString());
    sb.write(DateFormat("HH:mm").format(DateTime.now()).toString());
    final datetime = sb.toString();

    var primary = false;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 211, 13),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 170, left: 40, right: 40, bottom: 70),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                          print("video: $primary");
                          final sb = StringBuffer();
                          sb.write(DateFormat("yyyy-MM-dd")
                              .format(DateTime.now())
                              .toString());
                          sb.write(DateFormat("HH:mm")
                              .format(DateTime.now())
                              .toString());
                          final datetime = sb.toString();
                          // print(datetime);

                          Upload.get().then((QuerySnapshot querySnapshot) {
                            for (var doc in querySnapshot.docs) {
                              print(doc.id);
                              if (datetime == doc['DateTime']) {
                                // print(doc['Name']);
                                // print(doc['Url']);
                                // print(doc['Question']);
                                print(doc.reference);
                                primary = true;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VideoPage(url: doc['Url'].toString()),
                                  ),
                                );
                              }

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         VideoPage(url: doc['Url'].toString()),
                              //   ),
                              // );

                              // print("BookingTime" + doc['DateTime']);
                              // print("CurrentTime" + datetime);
                              // print(doc['Date']);
                              // print(doc['Time']);
                            }
                            if (!primary) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title:
                                      const Text('It is not booked time now!'),
                                  content: const Text('You can check again!'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => VideoPage(),
                          //   ),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 228, 97, 9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            )),
                        child: Text(
                          'Pubs',
                          style: TextStyle(color: Colors.white, fontSize: 35),
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
                    color: Colors.yellow,
                  ),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 255, 255, 255)),
                          child: Center(
                            child: SizedBox(
                              height: 100,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  print("answer: $primary");
                                  final sb = StringBuffer();
                                  sb.write(DateFormat("yyyy-MM-dd")
                                      .format(DateTime.now())
                                      .toString());
                                  sb.write(DateFormat("HH:mm")
                                      .format(DateTime.now())
                                      .toString());
                                  final datetime = sb.toString();
                                  Upload.get()
                                      .then((QuerySnapshot querySnapshot) {
                                    for (var doc in querySnapshot.docs) {
                                      if (primary) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AnswerPage(
                                              question:
                                                  doc['Question'].toString(),
                                              id: doc.id.toString(),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                    if (!primary) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                              'It is not booked time now!'),
                                          content: const Text(
                                              'You can check again!'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 6, 115, 6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                    )),
                                child: Text(
                                  'Cadeaux',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
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
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 124, 124, 124),
                              ),
                              child: Text(
                                'Home',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ), //BoxDecoration
                ), //Container
              ),
            ],
          ),
        ),
      ),
    );
  }
}
