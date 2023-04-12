// // ignore_for_file: must_be_immutable

// import 'package:app_55hz/domain/thread.dart';
// import 'package:app_55hz/main/admob.dart';
// import 'package:app_55hz/presentation/search/search_model.dart';
// import 'package:app_55hz/presentation/search/search_page.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:provider/provider.dart';

// class SearchTabPage extends StatelessWidget {
//   final String uid;
//   final String searchWord;
//   SearchTabPage({Key key, this.uid, this.searchWord}) : super(key: key);
//   BannerAd banner = BannerAd(
//     listener: const BannerAdListener(),
//     size: AdSize.banner,
//     adUnitId: AdInterstitial.bannerAdUnitId,
//     request: const AdRequest(),
//   )..load();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: SearchModel()..fetchThread(),
//       child: Consumer<SearchModel>(
//         builder: (context, model, child) {
//           final threads = model.threads;
//           final tab = threads
//               .map(
//                 (Thread thread) => Tab(
//                   text: thread.title,
//                 ),
//               )
//               .toList();
//           final listPage = threads
//               .map((Thread thread) => SearchPage(
//                     thread: thread,
//                     uid: uid,
//                     searchWord: searchWord,
//                   ))
//               .toList();
//           return DefaultTabController(
//             length: tab.length,
//             child: Scaffold(
//                 backgroundColor: const Color(0xffFCFAF2),
//                 appBar: AppBar(
//                   flexibleSpace: const Image(
//                     image: AssetImage('images/washi1.png'),
//                     fit: BoxFit.cover,
//                     color: Color(0xff33A6B8),
//                     colorBlendMode: BlendMode.modulate,
//                   ),
//                   title: Text(
//                     '検索',
//                     style: GoogleFonts.sawarabiMincho(
//                       color: const Color(0xffFCFAF2),
//                       fontSize: 25.0,
//                     ),
//                   ),
//                   centerTitle: true,
//                   elevation: 0.0,
//                   bottom: TabBar(
//                       tabs: tab,
//                       isScrollable: true,
//                       labelStyle: GoogleFonts.sawarabiMincho(
//                           fontSize: 14.0, fontWeight: FontWeight.bold)),
//                 ),
//                 body: TabBarView(children: listPage),
//                 bottomNavigationBar: child),
//           );
//         },
//         child: SizedBox(
//           height: 64,
//           child: AdWidget(
//             ad: banner,
//           ),
//         ),
//       ),
//     );
//   }
// }
