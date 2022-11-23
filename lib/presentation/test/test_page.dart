import 'package:app_55hz/presentation/test/test_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(DateFormat("yyyy年MM月dd日")
                                  .format(model.dateTime)),
                              ElevatedButton(
                                child: const Text('日付'),
                                onPressed: () async {
                                  await model.datePicker2(context);
                                  //時計UIを使用する場合はdatePicker2をtdatePickerへ変更
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(DateFormat(
                                      "${model.time2.hour}時${model.time2.minute}分")
                                  //時計UIを使用する場合はtime2をtimeへ変更
                                  .format(model.dateTime)),
                              ElevatedButton(
                                child: const Text('時間'),
                                onPressed: () async {
                                  await model.timePicker2(context);
                                  //時計UIを使用する場合はtimePicker2をtimePickerへ変更
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        child: Text('送信'),
                        onPressed: () async {
                          await model.addTo();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}
