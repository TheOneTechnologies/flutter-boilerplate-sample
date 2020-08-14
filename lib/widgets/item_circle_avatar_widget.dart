import 'package:flutter/material.dart';

Widget avatar(String url) {
  return Container(
    height: 50,
    width: 50,
    child: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 50,
        backgroundImage: NetworkImage(url)),
  );
}
