import 'package:cloud_firestore/cloud_firestore.dart';

class Profilenetwork{

  static Future<Map<String, dynamic>> getUserinfoById(String userid) async {
    Map<String, dynamic> userinfo = {};
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(userid)
        .get()
        .then((value) {
      userinfo['userid'] = value['uid'];
      userinfo['username'] = value['name'];
      userinfo['userimage'] = value['userimage'];
      userinfo['age'] = value['age'];
      userinfo['city'] = value['city'];
      userinfo['country'] = value['country'];
      userinfo['email'] = value['email'];
      userinfo['country'] = value['country'];
      userinfo['lastseen'] = value['lastseen'];
      userinfo['phonenumber'] = value['phonenumber'];
    });
    return userinfo;
  }



  static Future<void> deletechat(String chatid) async {
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
      });
    });
    await FirebaseFirestore.instance.collection('Chats').doc(chatid).delete();
  }


}