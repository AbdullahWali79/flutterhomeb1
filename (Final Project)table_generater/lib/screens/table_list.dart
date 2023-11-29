import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_generater/screens/quiz_screen.dart';

import '../utils/constants.dart';

class ListOfTable extends StatefulWidget {
  const ListOfTable({Key? key}) : super(key: key);

  @override
  State<ListOfTable> createState() => _ListOfTableState();
}

class _ListOfTableState extends State<ListOfTable> {
  @override
  User? current = FirebaseAuth.instance.currentUser;
  int? tablenumber, carMakeModel, qnumber;
  var setDefaultMake = true, setDefaultMakeModel = true;
  List<int> items = List<int>.generate(10, (index) => index + 1);
  @override
  void initState() {
    super.initState();
  }

  bool a = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'List of tables',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tusers')
            .doc(current?.uid)
            .collection('table')
            .orderBy('number')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Safety check to ensure that snapshot contains data
          // without this safety check, StreamBuilder dirty state warnings will be thrown
          if (!snapshot.hasData) return Container();
          // Set this value for default,
          // setDefault will change if an item was selected
          // First item from the List will be displayed
          if (setDefaultMake) {
            tablenumber = snapshot.data?.docs[0].get('number');
            debugPrint('setDefault make: $tablenumber');
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Select table number and Question Limit to start Quiz",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          "Select table number",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        Spacer(),
                        DropdownButton(
                          dropdownColor: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: false,
                          value: tablenumber,
                          items: snapshot.data?.docs.map((value) {
                            return DropdownMenuItem(
                              value: value.get('number') ?? 0,
                              child: Text('${value.get('number')}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            debugPrint('selected onchange: $value');
                            setState(
                              () {
                                debugPrint('make selected: $value');
                                // Selected value will be stored
                                tablenumber = value as int?;
                                // Default dropdown value won't be displayed anymore
                                setDefaultMake = false;
                                // Set makeModel to true to display first car from list
                                setDefaultMakeModel = true;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Text(
                          "How many Questions?",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        Spacer(),
                        DropdownButton<int>(
                          dropdownColor: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: false,
                          value: qnumber ?? 1,
                          items: items
                              .map((e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text(
                                      e.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              qnumber = value;
                              a = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              a == false
                  ? SizedBox(
                      height: 0,
                    )
                  : Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        child: MaterialButton(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            print(tablenumber);
                            print(qnumber);
                            Get.to(QuizScreen(
                                number: tablenumber ?? 2,
                                question: qnumber ?? 2));
                          },
                          child: Text(
                            "Generate Quiz",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
