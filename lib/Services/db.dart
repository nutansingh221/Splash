import 'package:cloud_firestore/cloud_firestore.dart';

class Dbfunctions {
  Future<void> uploadUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .get();
  }

  searchByEmail(String userEmail) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: userEmail)
        .get();
  }

  createChatRoom(String chatRoomID, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }
}
