import 'package:app_55hz/domain/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditThreadModel extends ChangeNotifier {
  List<Thread> threads = [];
  List<String> myThreads = [];
  bool? isMyThreads;
  bool? threadSort;
  bool? resSort;

  Future getConfig() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    threadSort = pref.getBool('threadSort');
    resSort = pref.getBool('resSort');
    isMyThreads = pref.getBool('isMyThreads');

    if (threadSort == null) {
      await pref.setBool('threadSort', false);
      threadSort = pref.getBool('threadSort');
      print(threadSort);
    }
    if (resSort == null) {
      await pref.setBool('resSort', true);
      resSort = pref.getBool('resSort');
      print(resSort);
    }
    if (isMyThreads == null) {
      await pref.setBool('isMyThreads', false);
      isMyThreads = pref.getBool('isMyThreads');
      print(isMyThreads);
    }

    notifyListeners();
  }

  Future setTrueTheradSort() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('threadSort', true);
    threadSort = pref.getBool('threadSort');
    print(threadSort);
    notifyListeners();
  }

  Future setFalseTheradSort() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('threadSort', false);
    threadSort = pref.getBool('threadSort');
    print(threadSort);
    notifyListeners();
  }

  Future setTrueResSort() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('resSort', true);
    resSort = pref.getBool('resSort');
    print(resSort);
    notifyListeners();
  }

  Future setFalseResSort() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('resSort', false);
    resSort = pref.getBool('resSort');
    print(resSort);
    notifyListeners();
  }

  Future setTrueisMyThreads() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isMyThreads', true);
    isMyThreads = pref.getBool('isMyThreads');
    print(isMyThreads);
    notifyListeners();
  }

  Future setFalseIsMyThreads() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isMyThreads', false);
    isMyThreads = pref.getBool('isMyThreads');
    print(isMyThreads);
    notifyListeners();
  }

  Future clearDb() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  Future fetchThread() async {
    final docs = await FirebaseFirestore.instance
        .collection('thread')
        .orderBy('createdAt', descending: true)
        .get();
    final threads = docs.docs.map((doc) => Thread(doc)).toList();
    this.threads = threads;
    notifyListeners();
  }

  Future fetchMyThreads(String uid) async {
    final docs = FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('myThread')
        .orderBy('createdAt', descending: true)
        .snapshots();
    docs.listen((snapshots) async {
      final favoriteThreads =
          snapshots.docs.map((doc) => Thread(doc).documentID!).toList();
      myThreads = favoriteThreads;
      notifyListeners();
    });
  }

  Future addMyThreads(
      String uid, String id, String title, DateTime createdAt) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('myThread')
        .doc(id)
        .set({'title': title, 'createdAt': createdAt});
  }

  Future removeMyThreads(String uid, String id) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('myThread')
        .doc(id)
        .delete();
  }
}
