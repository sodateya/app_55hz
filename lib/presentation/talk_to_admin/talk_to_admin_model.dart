// ignore_for_file: missing_return

import 'dart:io';

import 'package:app_55hz/domain/talk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TalkToAdminModel extends ChangeNotifier {
  List<Talk> talks = [];
  List blockUser = [];
  List accessBlockList = [];
  final firestore = FirebaseFirestore.instance;
  int documentLimit = 13;
  DocumentSnapshot? lastDocument;
  String comment = '';
  final picker = ImagePicker();
  File? imageFile;
  bool isLoading = false;
  final adominUid = 'rerVaRIZp9Zo9HTu8iwySUWAmi02';

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future getTalk() async {
    final querySnapshot = firestore
        .collection('inquiry')
        .orderBy('createdAt', descending: true)
        .limit(documentLimit)
        .snapshots();
    try {
      querySnapshot.listen((snapshots) async {
        lastDocument = snapshots.docs.last;
        final talks = snapshots.docs.map((doc) => Talk(doc)).toList();
        this.talks = talks;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future getMoreTalk() async {
    final docs = firestore
        .collection('inquiry')
        .orderBy('createdAt', descending: true)
        .limit(documentLimit)
        .startAfterDocument(lastDocument!)
        .limit(10)
        .snapshots();
    docs.listen((snapshots) async {
      try {
        lastDocument = snapshots.docs.last;
        final talks = snapshots.docs.map((doc) => Talk(doc)).toList();
        this.talks.addAll(talks);
      } catch (e) {
        print('終了');
      }
      notifyListeners();
    });
  }

  Future deleteAdd(Talk talk) async {
    await FirebaseFirestore.instance
        .collection('inquiry')
        .doc(talk.documentID)
        .delete();
    notifyListeners();
  }

  Future addThreadToFirebase(String uid) async {
    final db = FirebaseFirestore.instance.collection('inquiry').doc();
    if (comment.isEmpty && imageFile == null) {
      throw ('メッセージまたは写真を入力してください');
    }
    String? imgURL;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('talk/${db.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    await db.set({
      'comment': comment,
      'createdAt': FieldValue.serverTimestamp(),
      'uid': uid,
      'count': 0,
      'badCount': [],
      'url': '',
      'name': handleName,
      'imgURL': imgURL ?? '',
    });
  }

  Future addImage(String uid) async {
    final doc = FirebaseFirestore.instance.collection('inquiry').doc();
    String? imgURL;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('talk/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }
    await doc.set({
      'comment': '',
      'createdAt': FieldValue.serverTimestamp(),
      'uid': uid,
      'count': 0,
      'badCount': [],
      'url': '',
      'name': handleName,
      'imgURL': imgURL ?? '',
    });
    // push(message, token, myInfo);
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 400, maxWidth: 400);
    imageFile = File(pickedFile!.path);
    return imageFile;
  }

  Future resetImage() async {
    imageFile = null;
    notifyListeners();
  }

  String? handleName;

  Future getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('handleName') == null) {
      await pref.setString('handleName', '名無しさん');
      handleName = pref.getString('handleName');
    } else {
      handleName = pref.getString('handleName');
    }
    notifyListeners();
  }

  int count = 0;
}
