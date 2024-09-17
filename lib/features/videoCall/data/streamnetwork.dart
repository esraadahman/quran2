import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Streamnetwork {

  static Future<String> takeAndUploadImage( XFile? image) async {
    if (image != null) {
      File file = File(image.path);

      var metadata = SettableMetadata(contentType: "image/jpeg");
      var imgname = basename(image.path);
      var ref = FirebaseStorage.instance.ref().child(imgname);
      await ref.putFile(file, metadata);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;

      //  sendmassage(chatid, downloadURL, "image");
    } else {
      print("No image selected");
      return "";
    }
  }

// create stream at firebase firestore
  static Future <void> createstream(
      String streamname, String streamimage, String streamid) async {
    String username = "";
    String userimage = "";
    String usercity = "";
    String usercountry = "";
    await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      username = value['name'];
      userimage = value['userimage'];
      usercity = value['city'];
      usercountry = value['country'];
    });

    await FirebaseFirestore.instance.collection('Streams').add({
      'streamname': streamname,
      'streamimage': streamimage,
      'streamid': streamid,
      'username': username,
      'userimage': userimage,
      'userlocation': "$usercity - $usercountry",
      'viewers': 0

      // 'timestamp': FieldValue.serverTimestamp(),
    });
  }

// get streams
  static Stream<QuerySnapshot> getstreams() {
    return FirebaseFirestore.instance.collection('Streams').snapshots();
  }


   static Future<String> getusername()async {
    String username = "";
   await FirebaseFirestore.instance
        .collection("UserInfo")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      username = value["name"];
    });
    return username;
  }
}
