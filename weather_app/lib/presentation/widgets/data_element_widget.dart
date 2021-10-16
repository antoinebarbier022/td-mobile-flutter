import 'package:flutter/material.dart';

class DataElementWidget extends StatelessWidget {
  DataElementWidget(
      {required this.title, required this.data, required this.type});

  String title;
  String data;
  String type;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
          ),
          const SizedBox(
            height: 4,
          ),
          Text("$data $type",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ]);
  }
}
