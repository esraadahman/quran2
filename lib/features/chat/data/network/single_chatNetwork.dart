import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:qurane2/features/chat/data/network/chatsNetwork.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class SingleChatNetwork {
  static Future<void> sendmassage(
      String chatid, String massage, String type) async {
    await FirebaseFirestore.instance.collection('Chats').doc(chatid).update({
      'lastmassage': type == "text"
          ? massage
          : type == "image"
              ? "Media"
              : 'voice massage',
      'timestamp': DateTime.now().microsecondsSinceEpoch,
      'lastmassagetime': DateFormat.Hm("en_US").format(DateTime.now())
    });

    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .add({
      'senderid': FirebaseAuth.instance.currentUser!.uid,
      'sendername': (await ChatsNetwork.getUserinfo()).username,
      'senderimage': (await ChatsNetwork.getUserinfo()).userimage,
      'massage': massage,
      'type': type,
      'timestamp': DateTime.now().microsecondsSinceEpoch,
      'time': DateFormat.Hm("en_US").format(DateTime.now()),
      'seen': false
    });
  }

  static Future<void> takeAndUploadImage(String chatid, XFile? image) async {
    if (image != null) {
      File file = File(image.path);

      var metadata = SettableMetadata(contentType: "image/jpeg");
      var imgname = basename(image.path);
      var ref = FirebaseStorage.instance.ref().child(imgname);
      await ref.putFile(file, metadata);
      String downloadURL = await ref.getDownloadURL();

      sendmassage(chatid, downloadURL, "image");
    } else {
      print("No image selected");
    }
  }

  static Future<void> uploadVideo(String chatid, XFile? video) async {
    if (video != null) {
      try {
        File file = File(video.path);
        var metadata = SettableMetadata(contentType: "video/mp4");
        var videoname = basename(video.path);
        var ref = FirebaseStorage.instance.ref().child(videoname);

        await ref.putFile(file, metadata);
        String downloadURL = await ref.getDownloadURL();
        sendmassage(chatid, downloadURL, "video");
      } catch (e) {
        print("Error uploading video: $e");
      }
    } else {
      print("No video selected");
    }
  }

  static Stream<QuerySnapshot> getmassages(String chatid) {
    return FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  static String getcurrentuserid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<void> uploadAudio(
      String chatid, String path, String type) async {
    var ref = await FirebaseStorage.instance
        .ref()
        .child("records")
        .child("${Uuid().v4()}.m4a");

    var metadata = SettableMetadata(
      contentType: "audio/x-m4a",
    );
    await ref.putFile(File(path), metadata);

    sendmassage(chatid, await ref.getDownloadURL(), type);
  }

  // update lasetseen
  static Future<void> updateLastseen() async {
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'lastseen': DateFormat.Hm("en_US").format(DateTime.now())});
  }







  static Future<String> getLastseen(String userid) async {
    String lastseen = "";
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(userid)
        .get()
        .then((value) {
      lastseen = value['lastseen'];
    });
    return lastseen;
  }






    static Future<void> markSeen(String chatid, String senderid) async {
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .where('senderid', isEqualTo: senderid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.update({'seen': true});
      });
    });
  }


    static Future<void> deletemassage(String chatid, String massageid) async {
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(chatid)
        .collection('Massages')
        .doc(massageid)
        .delete();
  }
}
