import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class Conversation extends StatefulWidget {
  final String frindUid;
  final String friendName;

  const Conversation(
      {Key? key, required this.frindUid, required this.friendName})
      : super(key: key);

  @override
  _ConversationState createState() => _ConversationState(frindUid!, friendName);
}

class _ConversationState extends State<Conversation> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final String friendUid, friendName;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  var chatDocId;
  var data;
  TextEditingController chatcontroller = new TextEditingController();
  _ConversationState(this.friendUid, this.friendName);
  Timer timer = Timer(Duration(seconds: 2), () {});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();

    // init();
    // if (mounted) {
    //   setState(() {});
    // }
  }

  void checkUser() async {
    chats
        .where("users", isEqualTo: {
          currentUserId: FirebaseAuth.instance.currentUser?.displayName,
          friendUid: friendName
        })
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) async {
            if (querySnapshot.docs.isNotEmpty) {
              setState(() {
                chatDocId = querySnapshot.docs.single.id;
              });
            } else {
              await chats.add({
                'users': {
                  currentUserId: FirebaseAuth.instance.currentUser?.displayName,
                  friendUid: friendName
                },
                'names': {
                  currentUserId: FirebaseAuth.instance.currentUser?.displayName,
                  friendUid: friendName
                }
              }).then((value) {
                chatDocId = value;
                // setState(() {
                //   chatDocId = value;
                // });
              });
            }
          },
        )
        .catchError((e) {
          log('', error: e);
        });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  bool isSender(String friend) {
    return friend == currentUserId;
  }

  Alignment getAlignment(friend) {
    if (friend == currentUserId) {
      return Alignment.topRight;
    }
    return Alignment.topLeft;
  }

  void sendMessage(String text) {
    if (text == '') return;
    chats.doc(chatDocId).collection('messages').add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': currentUserId,
      'msg': text
    }).then((value) {
      chatcontroller.text = '';
    });
  }

  void init() {
    timer = Timer(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chats
          .doc(chatDocId)
          .collection('messages')
          .orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('something went wrong'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Container(
            child: CircularProgressIndicator(),
          ));
        }
        if (snapshot.hasData) {
          // init();
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(friendName),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Icon(CupertinoIcons.phone),
              ),
              previousPageTitle: "Back",
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                      child: ListView(
                    reverse: true,
                    children: snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                        data = document.data()!;
                        log(document.toString());
                        log(data['msg']);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ChatBubble(
                            clipper: ChatBubbleClipper6(
                              nipSize: 10,
                              radius: 30,
                              type: isSender(data['uid'].toString())
                                  ? BubbleType.sendBubble
                                  : BubbleType.receiverBubble,
                            ),
                            alignment: getAlignment(data['uid'].toString()),
                            margin: EdgeInsets.only(top: 20),
                            backGroundColor: isSender(data['uid'].toString())
                                ? Colors.redAccent
                                : Color(0xffE7E7ED),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(data['msg'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: isSender(
                                                        data['uid'].toString())
                                                    ? Colors.white
                                                    : Colors.black),
                                            //maxLines: 100,
                                            overflow: TextOverflow.ellipsis),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        data['createdOn'] == null
                                            ? DateTime.now().toString()
                                            : data['createdOn']
                                                .toDate()
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                isSender(data['uid'].toString())
                                                    ? Colors.white
                                                    : Colors.black),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CupertinoTextField(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          controller: chatcontroller,
                        ),
                      )),
                      CupertinoButton(
                          child: Icon(Icons.send_rounded),
                          onPressed: () => sendMessage(chatcontroller.text))
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
