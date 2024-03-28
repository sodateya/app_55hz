import 'package:flutter/material.dart';

class DonutWidget extends StatelessWidget {
  const DonutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.amber, width: 80),
        color: Colors.transparent, // 背景を透明に設定
      ),
    );
  }
}
