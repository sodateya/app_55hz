import 'dart:io';

import 'package:app_55hz/domain/post.dart';
import 'package:app_55hz/domain/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

class ListModel extends ChangeNotifier {
  List<Thread> threads = [];
  List<Post> posts = [];
  List blockUser = [];

  List myList = [];
  int documentLimit = 10;
  final firestore = FirebaseFirestore.instance;
  DocumentSnapshot lastDocument;
  String timeSort = 'createdAt';
  bool isMyThreads;
  bool threadSort;
  bool resSort;
  var count = 0;

  bool isUpdateToday(Post post, int index) {
    final isUpdateToday =
        '${posts[index].upDateAt.year}/${posts[index].upDateAt.month}/${posts[index].upDateAt.day}' ==
            '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
    return isUpdateToday;
  }

  Future getToken(String uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('token$uid') == null) {
      await pref.setBool('token$uid', false);
      final db = await firestore.collection('user').doc(uid).get();
      final isToken = db.data()['pushToken'];
      if (isToken == null) {
        final token = await FirebaseMessaging.instance.getToken();
        await firestore.collection('user').doc(uid).set({
          'uid': uid,
          'uid20': uid.substring(20),
          'udid': await FlutterUdid.udid,
          'pushToken': token
        });
        await pref.setBool('$uid', true);
      }
    } else {
      print('OK');
    }
  }

  Future checkMyBD(String uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = await FirebaseMessaging.instance.getToken();

    if (pref.getBool('MyDB$uid') == null) {
      await pref.setBool('MyDB$uid', false);
      try {
        final doc = await firestore.collection('user').doc(uid).get();
        doc.data()['uid'] != null;
      } catch (e) {
        await firestore.collection('user').doc(uid).set({
          'uid': uid,
          'uid20': uid.substring(20),
          'udid': await FlutterUdid.udid,
          'pushToken': token
        });
        await firestore
            .collection('user')
            .doc(uid)
            .collection('blockList')
            .doc(uid.substring(20))
            .set({'blockUsers': []});
        await firestore
            .collection('user')
            .doc(uid)
            .collection('favoriteList')
            .doc(uid.substring(25))
            .set({'favoriteThreads': []});
        await pref.setBool('MyDB$uid', true);
      }
    }
    notifyListeners();
  }

  Future fetchVersion(context) async {
    final doc = await firestore.collection('config').doc('config').snapshots();
    doc.listen((snapShoats) async {
      final version =
          Version.parse(snapShoats.data()['ios_force_app_version'] as String);
      final packageInfo = await PackageInfo.fromPlatform();
      final appVersion = Version.parse(packageInfo.version);
      if (appVersion < version) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black54,
              title: Text('新しいバージョンが利用可能です。ストアより更新版を入手して、ご利用下さい。',
                  style: GoogleFonts.sawarabiMincho(
                      color: const Color(0xffFCFAF2))),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text(
                        '新しいバージョンを入手',
                        style: GoogleFonts.sawarabiMincho(
                            textStyle: Theme.of(context).textTheme.headline4,
                            color: const Color(0xff33A6B8),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (Platform.isIOS) {
                          await launch(
                              'https://apps.apple.com/jp/app/9%E3%81%A1%E3%82%83%E3%82%93%E3%81%AD%E3%82%8B-%E6%8E%B2%E7%A4%BA%E6%9D%BF%E3%82%A2%E3%83%97%E3%83%AA/id1608009439');
                        } else {
                          await launch(
                              'https://play.google.com/store/apps/details?id=com.soda.app_55hz');
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }
    });
    doc.listen((snapshots) async {
      final banList = await snapshots.data()['banList'];
      String udid = await FlutterUdid.udid;
      if (banList.contains(udid)) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black54,
              title: Text('あなたはこのサービスを利用できません',
                  style: GoogleFonts.sawarabiMincho(
                      color: const Color(0xffFCFAF2))),
            );
          },
        );
      }
    });
    notifyListeners();
  }

  Future setConfig() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('resSort') == null) {
      await pref.setBool('resSort', true);
      print('resSortを作成しました');
    }

    if (pref.getBool('threadSort') == null) {
      await pref.setBool('threadSort', false);
      print('threadSortを作成しました');
    }

    if (pref.getBool('isMyThreads') == null) {
      await pref.setBool('isMyThreads', false);
      print('isMyThreadsを作成しました');
    }
    notifyListeners();
  }

  Future getConfig() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    threadSort = pref.getBool('threadSort');
    threadSort == false ? timeSort = 'createdAt' : timeSort = 'upDateAt';
    resSort = pref.getBool('resSort');
    notifyListeners();
  }

  Future upLoadUdid(uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('udid') == null || false) {
      await pref.setBool('udid', false);
      await firestore.collection('user').doc(uid).set({
        'uid': uid,
        'uid20': uid.substring(20),
        'udid': await FlutterUdid.udid
      });
      await pref.setBool('udid', true);
    }
  }

  Future changeTime() async {
    timeSort == 'createdAt' ? timeSort = 'upDateAt' : timeSort = 'createdAt';
    notifyListeners();
  }

  Future fetchThread(uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isMyThreads = pref.getBool('isMyThreads');
    if (isMyThreads == null) {
      await pref.setBool('isMyThreads', false);
      isMyThreads = false;
    } else {
      isMyThreads = pref.getBool('isMyThreads');
    }
    if (isMyThreads == false) {
      final threadDocs = await FirebaseFirestore.instance
          .collection('thread')
          .orderBy('createdAt', descending: true)
          .get();
      final threads = threadDocs.docs.map((doc) => Thread(doc)).toList();
      this.threads = threads;
    } else {
      final threadDocs = await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .collection('myThread')
          .orderBy('createdAt', descending: false)
          .get();
      final threads = threadDocs.docs.map((doc) => Thread(doc)).toList();
      this.threads = threads;
    }
    notifyListeners();
  }

  Future getPost(Thread thread, String sort) async {
    final querySnapshot = firestore
        .collection('thread')
        .doc(thread.documentID)
        .collection('post')
        .orderBy(sort, descending: true)
        .limit(documentLimit)
        .snapshots();
    try {
      querySnapshot.listen((snaphsots) async {
        lastDocument = snaphsots.docs.last;
        final posts = snaphsots.docs.map((doc) => Post(doc)).toList();
        this.posts = posts;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future getAll(Thread thread, String sort) async {
    final querySnapshot = firestore
        .collectionGroup('post')
        .limit(documentLimit)
        .orderBy(sort, descending: true)
        .snapshots();
    try {
      querySnapshot.listen((snaphsots) async {
        lastDocument = snaphsots.docs.last;
        final posts = snaphsots.docs.map((doc) => Post(doc)).toList();
        this.posts = posts;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future getMorePost(Thread thread, String sort) async {
    final docs = firestore
        .collection('thread')
        .doc(thread.documentID)
        .collection('post')
        .orderBy(sort, descending: true)
        .startAfterDocument(lastDocument)
        .limit(10)
        .snapshots();
    docs.listen((snapshots) async {
      try {
        lastDocument = snapshots.docs.last;
        final posts = snapshots.docs.map((doc) => Post(doc)).toList();
        this.posts.addAll(posts);
      } catch (e) {
        print('終了');
      }
      notifyListeners();
    });
  }

  Future getMoreAllPost(Thread thread, String sort) async {
    final docs = firestore
        .collectionGroup('post')
        .orderBy(sort, descending: true)
        .startAfterDocument(lastDocument)
        .limit(10)
        .snapshots();
    docs.listen((snapshots) async {
      try {
        lastDocument = snapshots.docs.last;
        final posts = snapshots.docs.map((doc) => Post(doc)).toList();
        this.posts.addAll(posts);
      } catch (e) {
        print('終了');
      }
      notifyListeners();
    });
  }

  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future getUpdateToday(Thread thread, String sort) async {
    final querySnapshot = firestore
        .collectionGroup('post')
        .limit(documentLimit)
        .orderBy('upDateAt', descending: true)
        .where('upDateAt', isGreaterThanOrEqualTo: today)
        .snapshots();
    try {
      querySnapshot.listen((snaphsots) async {
        lastDocument = snaphsots.docs.last;
        final posts = snaphsots.docs.map((doc) => Post(doc)).toList();
        posts.sort(((a, b) => b.postCount.compareTo(a.postCount)));
        this.posts = posts;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future getMoreUpDateToday(Thread thread, String sort) async {
    final docs = firestore
        .collectionGroup('post')
        .orderBy('upDateAt', descending: true)
        .where('upDateAt', isGreaterThanOrEqualTo: today)
        .orderBy('postCount', descending: true)
        .startAfterDocument(lastDocument)
        .limit(10)
        .snapshots();
    docs.listen((snapshots) async {
      try {
        lastDocument = snapshots.docs.last;
        final posts = snapshots.docs.map((doc) => Post(doc)).toList();
        posts.sort(((a, b) => b.postCount.compareTo(a.postCount)));
        this.posts.addAll(posts);
      } catch (e) {
        print('終了');
      }
      notifyListeners();
    });
  }

  // ignore: missing_return
  Future badAdd(Thread thread, String postDocumentID, String uid) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(thread.documentID)
        .collection('post')
        .doc(postDocumentID)
        .update({
      'badCount': FieldValue.arrayUnion([uid])
    });
    notifyListeners();
  }

  Future badAddforAll(String threadID, String postID, String uid) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(threadID)
        .collection('post')
        .doc(postID)
        .update({
      'badCount': FieldValue.arrayUnion([uid])
    });
    notifyListeners();
  }

  // ignore: missing_return
  Future deleteMyThread(Thread thread, String postDocID) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(thread.documentID)
        .collection('post')
        .doc(postDocID)
        .delete();
    notifyListeners();
  }

  Future deleteMyThreadforAll(String threadID, String postID) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(threadID)
        .collection('post')
        .doc(postID)
        .delete();
    notifyListeners();
  }

  Future addToBlockList(String uid, String blockUser) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .doc(uid.substring(20))
        .update({
      'blockUsers': FieldValue.arrayUnion([blockUser])
    });
  }

  Future removeToBlockList(String uid, String blockUser) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .doc(uid.substring(20))
        .update({
      'blockUsers': FieldValue.arrayRemove([blockUser])
    });
  }

  Future fetchBlockList(String uid) async {
    final favoritePost = FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .doc(uid.substring(20))
        .snapshots();
    favoritePost.listen((snapshots) async {
      final blockUsers = await snapshots.data()['blockUsers'];
      blockUser = blockUsers;
      notifyListeners();
    });
  }

  Future getSearchThread(String searchWord) async {
    final querySnapshot = await firestore
        .collectionGroup('post')
        .orderBy('createdAt', descending: true)
        .where('title', arrayContains: [searchWord])
        .limit(documentLimit)
        .get();
    try {
      lastDocument = querySnapshot.docs.last;
      final posts = querySnapshot.docs.map((doc) => Post(doc)).toList();
      this.posts = posts;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future addRead(Thread thread, String post, String uid) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(thread.documentID)
        .collection('post')
        .doc(post)
        .update({
      'read': FieldValue.arrayUnion([uid])
    });
    notifyListeners();
  }

  Future addReadforAll(String threadID, String post, String uid) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(threadID)
        .collection('post')
        .doc(post)
        .update({
      'read': FieldValue.arrayUnion([uid])
    });
    notifyListeners();
  }
}
