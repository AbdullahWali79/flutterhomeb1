import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_generater/screens/result_show.dart';
import 'package:table_generater/utils/constants.dart';

import '../dbsqflite/db.dart';
import '../dbsqflite/model.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({required this.number, required this.question});
  final int number;
  final int question;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  MemoDbProvider memoDb = MemoDbProvider();
  User? current = FirebaseAuth.instance.currentUser;
  Random r1 = new Random();
  List<bool> data = [];
  int a = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  int e = 0;
  int priority = 0;
  int number = 0;
  int chang = 1;
  bool clr1 = true;
  bool clr2 = true;
  bool clr3 = true;
  bool clr4 = true;
  bool ans1 = false;
  bool ans2 = false;
  bool ans3 = false;
  bool ans4 = false;
  bool v = true;
  bool btnvisible = false;
  int countBoolList(List<bool> boolList) {
    int count = 0;
    for (int i = 0; i < boolList.length; i++) {
      if (boolList.elementAt(i) == true) {
        count++;
      }
    }
    return count;
  }

  int countBoolFalseList(List<bool> boolList) {
    int count = 0;
    for (int i = 0; i < boolList.length; i++) {
      if (boolList.elementAt(i) == false) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Table Generator Game',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            v == true
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 200,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          number = widget.number;
                          a = r1.nextInt(10) + 1;
                          b = r1.nextInt(4) + 1;
                          c = r1.nextInt(8) + 5;
                          d = r1.nextInt(12) + 9;
                          e = r1.nextInt(16) + 13;
                          priority = r1.nextInt(4) + 1;
                          v = false;
                          btnvisible = true;
                        });
                      },
                      child: Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black),
                          child: Center(
                            child: Text(
                              "Start Quiz!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 0,
                  ),
            v == false
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  chang.toString(),
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "$number x $a = _____",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 0,
                  ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Visibility(
                      visible: btnvisible,
                      child: TextButton(
                          child: (priority == 1)
                              ? Text(
                                  "${number * a}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text("${(number * a) + b}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                          onPressed: () {
                            setState(() {
                              if (priority == 1) {
                                ans1 = true;
                                clr1 = false;
                                data.add(true);
                              } else {
                                data.add(false);
                                clr1 = false;
                                if (priority == 2) {
                                  ans2 = true;
                                  clr2 = false;
                                } else if (priority == 3) {
                                  ans3 = true;
                                  clr3 = false;
                                } else if (priority == 4) {
                                  ans4 = true;
                                  clr4 = false;
                                }
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: clr1
                                  ? (Colors.grey)
                                  : (ans1 ? Colors.green : Colors.red))),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Visibility(
                      visible: btnvisible,
                      child: TextButton(
                          child: (priority == 2)
                              ? Text("${number * a}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                              : Text("${(number * a) + c}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                          onPressed: () {
                            setState(() {
                              if (priority == 2) {
                                ans2 = true;
                                clr2 = false;
                                data.add(true);
                              } else {
                                data.add(false);
                                clr2 = false;
                                if (priority == 1) {
                                  ans1 = true;
                                  clr1 = false;
                                } else if (priority == 3) {
                                  ans3 = true;
                                  clr3 = false;
                                } else if (priority == 4) {
                                  ans4 = true;
                                  clr4 = false;
                                }
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: clr2
                                  ? (Colors.grey)
                                  : (ans2 ? Colors.green : Colors.red))),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Visibility(
                    visible: btnvisible,
                    child: TextButton(
                        child: (priority == 3)
                            ? Text("${number * a}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                            : Text("${(number * a) + d}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                        onPressed: () {
                          setState(() {
                            if (priority == 3) {
                              ans3 = true;
                              clr3 = false;
                              data.add(true);
                            } else {
                              data.add(false);
                              clr3 = false;
                              if (priority == 2) {
                                ans2 = true;
                                clr2 = false;
                              } else if (priority == 1) {
                                ans1 = true;
                                clr1 = false;
                              } else if (priority == 4) {
                                ans4 = true;
                                clr4 = false;
                              }
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: clr3
                                ? (Colors.grey)
                                : (ans3 ? Colors.green : Colors.red))),
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Visibility(
                    visible: btnvisible,
                    child: TextButton(
                        child: (priority == 4)
                            ? Text("${number * a}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                            : Text("${(number * a) + e}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                        onPressed: () {
                          setState(() {
                            if (priority == 4) {
                              ans4 = true;
                              clr4 = false;
                              data.add(true);
                            } else {
                              data.add(false);
                              clr4 = false;
                              if (priority == 2) {
                                ans2 = true;
                                clr2 = false;
                              } else if (priority == 3) {
                                ans3 = true;
                                clr3 = false;
                              } else if (priority == 1) {
                                ans1 = true;
                                clr1 = false;
                              }
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: clr4
                                ? (Colors.grey)
                                : (ans4 ? Colors.green : Colors.red))),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: btnvisible,
              child: chang == widget.question
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        width: MediaQuery.of(context).size.width - 70,
                        child: MaterialButton(
                          color: Colors.red.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () async {
                            final memo = QuizModel(
                              id: 1,
                              totalquestion: data.length.toString(),
                              right: countBoolList(data).toString(),
                              wrong: countBoolFalseList(data).toString(),
                            );

                            await memoDb.addItem(memo);
                            var memos = await memoDb.fetchMemos();
                            print(memos[0].totalquestion);
                            FirebaseFirestore.instance
                                .collection("tusers")
                                .doc(current?.uid)
                                .collection('quiz')
                                .add({
                              "quiz": data,
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowResult(
                                          data: data,
                                        )));
                          },
                          child: Text("Show Result",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        width: MediaQuery.of(context).size.width - 70,
                        child: MaterialButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            setState(() {
                              a = r1.nextInt(10) + 1;
                              priority = r1.nextInt(4) + 1;
                              clr1 = true;
                              clr2 = true;
                              clr3 = true;
                              clr4 = true;
                              ans1 = false;
                              ans2 = false;
                              ans3 = false;
                              ans4 = false;
                              chang++;
                            });
                          },
                          child: Text("Next Question",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
