import 'package:app_55hz/%20presentation/top/widget/FAB/all_fab.dart';
import 'package:app_55hz/%20presentation/top/widget/FAB/category_fab.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Fab9ch extends ConsumerWidget {
  const Fab9ch({super.key, required this.thread});
  final Thread thread;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (thread.title) {
      case 'すべて' || '今日のトピック':
        return AllFab(thread: thread);
      default:
        return CategoryFab(thread: thread);
    }
  }
}
