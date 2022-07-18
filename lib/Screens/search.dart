import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splash/Screens/SearchResult.dart';
import 'package:splash/Screens/user_data_model.dart';
import 'package:splash/Services/db.dart';
import 'package:splash/Widgets/temp.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  Dbfunctions database = new Dbfunctions();
  bool isLoading = false, haveUserSearched = false;
  TextEditingController searchtextcontroller = new TextEditingController();

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');

  List<String> userDataModel = [];

//  createChatRoom(String userName){
//    List<String> users =[userName];
//    database.createChatRoom(chatRoomID, chatRoomMap)
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Temp.appBar(),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchtextcontroller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'search username...',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => searchResult(
                                  text: searchtextcontroller.text)));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.search),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchTitle extends StatelessWidget {
  final String userName, userEmail;
  const SearchTitle({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                userName,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(30)),
            child: Text('Message'),
          )
        ],
      ),
    );
  }
}
