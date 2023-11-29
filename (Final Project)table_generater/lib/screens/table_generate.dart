import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_generater/screens/table_list.dart';
import 'package:table_generater/utils/constants.dart';

class TableGenerater extends StatefulWidget {
  @override
  _TableGeneraterState createState() => _TableGeneraterState();
}

class _TableGeneraterState extends State<TableGenerater> {
  int _sliderTable = 50;
  int _sliderLimit = 5;
  User? current = FirebaseAuth.instance.currentUser;
  bool a = false;
  int num = 50;
  bool b = false;
  @override
  Widget build(BuildContext context) {
    List<Widget> table = [];
    for (int i = 1; i <= _sliderLimit; i++) {
      table.add(Visibility(
        visible: a,
        child: Text(
          '$num x $i = ${num * i} ',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ));
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Table Generator Game',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                      "Set your table number and limit number",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 26),
                    ),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Table",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Slider(
                        value: _sliderTable.toDouble(),
                        min: 1,
                        max: 99,
                        activeColor: Colors.black,
                        inactiveColor: Color(0xFF8D8E98),
                        onChanged: (double newvalue) {
                          setState(() {
                            _sliderTable = newvalue.round();
                          });
                        }),
                    Spacer(),
                    Text(
                      _sliderTable.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 50, right: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Limit",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Slider(
                        value: _sliderLimit.toDouble(),
                        min: 1,
                        max: 10,
                        activeColor: Colors.black,
                        inactiveColor: Color(0xFF8D8E98),
                        onChanged: (double newvalue) {
                          setState(() {
                            _sliderLimit = newvalue.round();
                          });
                        }),
                    Spacer(),
                    Text(
                      _sliderLimit.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                child: Container(
                  height: 40,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: b == true ? Colors.grey : Colors.black,
                    onPressed: b == true
                        ? () {}
                        : () {
                            setState(() {
                              a = true;
                              num = _sliderTable;
                              b = true;
                            });
                            FirebaseFirestore.instance
                                .collection('tusers')
                                .doc(current?.uid)
                                .collection('table')
                                .doc()
                                .set({'number': _sliderTable});
                          },
                    child: Text(
                      "Generate Table",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              a == false
                  ? SizedBox(
                      height: 0,
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(105, 105, 105, 0.90),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: table,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              a == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 30),
                          child: MaterialButton(
                            color: Colors.blue.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () {
                              Get.to(ListOfTable());
                            },
                            child: Text(
                              "List of tables",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 30),
                          child: MaterialButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () {
                              setState(() {
                                a = false;
                                b = false;
                              });
                            },
                            child: Text(
                              "Generate Table Again",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
