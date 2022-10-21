import 'package:flutter/material.dart';

class ApBar {
  static PreferredSizeWidget getAppbar({String? tittle}) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            leading: Image.asset('images/leaf.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))),
            centerTitle: true,
            titleTextStyle: const TextStyle(
                color: Colors.black, fontFamily: AutofillHints.addressCity),
            title:  Text(
              '$tittle',
              selectionColor: Colors.black,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white));
  }
}
