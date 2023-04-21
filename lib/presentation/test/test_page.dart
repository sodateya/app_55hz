import 'package:app_55hz/presentation/test/test_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class TestPage extends StatelessWidget {
  String uid;
  TestPage({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: TestModel(),
        child: Consumer<TestModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('test'),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Text(model.statusMessage()),
                    ElevatedButton(
                        onPressed: () {
                          model.startRecording();
                        },
                        child: const Text('start')),
                    ElevatedButton(
                        onPressed: () {
                          model.stopRecording();
                        },
                        child: const Text('stop')),
                    ElevatedButton(
                        onPressed: () async {
                          model.startPlaying();
                        },
                        child: const Text('play')),
                    ElevatedButton(
                        onPressed: () {
                          model.pausePlaying();
                        },
                        child: const Text('pose')),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
