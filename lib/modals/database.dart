import 'package:cloud_firestore/cloud_firestore.dart';

class Database{

getUserByEmail(String email) async {
    return await Firestore.instance
        .collection("register")
        .where("email", isEqualTo: email)
        .getDocuments();
}
  createchatroom(String chatRoomId, Map<String, dynamic> mapdata) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(mapdata)
        .catchError((onError) {
      print(onError);
    });
  }
 addConversationMessages(String chatroomid, Map<String, dynamic> messagemap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatroomid)
        .collection("Chats")
        .add(messagemap)
        .catchError((onError) {});
  }

  getConversationMessages(String chatroomid)async {
   return await Firestore.instance
        .collection("ChatRoom")
        .document(chatroomid)
        .collection("Chats").orderBy("time",descending: true)
        .snapshots();
  }

  getChatroom(String username)async{
  return  Firestore.instance.collection("ChatRoom").where("users",arrayContains:username).snapshots();
  }
  getallUsers()async{
   return await Firestore.instance.collection("users").snapshots();
  }

}