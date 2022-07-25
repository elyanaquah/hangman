import 'package:flutter/cupertino.dart';

Widget figureImage(bool visible, String path) {
  return Visibility(
      visible: visible,
      // ignore: sized_box_for_whitespace
      child: Container(
        width: 250,
        height: 250,
        child: Image.asset(path),
      ));
}
