import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main/home.dart';

AdInterstitial adInterstitial;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  adInterstitial = AdInterstitial();
  adInterstitial.createAd;
  runApp(MyApp(
    adInterstitial: adInterstitial,
  ));
  final messaging = FirebaseMessaging.instance;
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: false,
    sound: true,
  );
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key key, this.adInterstitial}) : super(key: key);

  final auth = FirebaseAuth.instance;
  AdInterstitial adInterstitial;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.sawarabiMinchoTextTheme(),
          cardTheme: const CardTheme(
            elevation: 9,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: Color(0xff939650),
          )),
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_literals_to_create_immutables
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: auth.currentUser == null
          ? Login(adInterstitial: adInterstitial)
          : Home(
              key: key,
              auth: auth,
              uid: auth.currentUser.uid,
              adInterstitial: adInterstitial),
    );
  }
}
