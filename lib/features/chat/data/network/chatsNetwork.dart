import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:qurane2/features/chat/data/model/userModel.dart';
import 'package:uuid/uuid.dart';

class ChatsNetwork {
  // get all users from firebase

  static Stream<QuerySnapshot> getallusers() {
    return FirebaseFirestore.instance
        .collection('UserInfo')
        .where('email', isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
  }

  static Future<void> createchat(
      String otheruserid, String otherusername, String otheruserimage) async {
    user_model userobj = await getUserinfo();

    var uuid = Uuid();
    String chatid = uuid.v4();
    await FirebaseFirestore.instance.collection('Chats').doc(chatid).set({
      'chatid': chatid,
      'userid': FirebaseAuth.instance.currentUser!.uid,
      'username': userobj.username,
      'userimage': userobj.userimage,
      'otheruserid': otheruserid,
      'otherusername': otherusername,
      'otheruserimage': otheruserimage,
      'lastmassage': "Created At",
      'timestamp': DateTime.now().microsecondsSinceEpoch,
      'part': [FirebaseAuth.instance.currentUser!.uid, otheruserid],
      'lastmassagetime': DateFormat.Hm("en_US").format(DateTime.now())
    });
    
  }

  static Future<user_model> getUserinfo() async {
    Map<String, dynamic> userinfo = {};
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userinfo['userid'] = value['uid'];
      userinfo['username'] = value['name'];
      userinfo['userimage'] = value['userimage'];
    });
    return user_model.fromJson(userinfo);
  }





    static Stream<QuerySnapshot> getuserchats() {
    return FirebaseFirestore.instance
        .collection('Chats')
        .where('part', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }





  static Future<bool> checkchat(String otheruserid) async {
    bool exist = false;
    await FirebaseFirestore.instance
        .collection('Chats')
        .where('part', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['part'].contains(otheruserid)) {
          exist = true;
        }
      });
    });
    return exist;
  }



  // search chat by username
  static Future<String> searchbyname(String username) async {
    String chatid = "";
    await FirebaseFirestore.instance
        .collection('Chats')
        .where('part', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['username'].toString().toUpperCase() ==
            username.toUpperCase()) {
          chatid = element.data()['chatid'];
        } else if (element.data()['otherusername'].toString().toUpperCase() ==
            username.toUpperCase()) {
          chatid = element.data()['chatid'];
        } else {
          chatid = "";
        }
      });
    });

    return chatid;
  }

  static Stream<QuerySnapshot> getchatbychatid(String chatid) {
    return FirebaseFirestore.instance
        .collection('Chats')
        .where('chatid', isEqualTo: chatid)
        .snapshots();
  }

  

}
