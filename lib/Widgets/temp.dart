import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash/Widgets/widget.dart';

class Temp {
  static PreferredSize appBar() {
    return PreferredSize(
        child: AppBarMain(), preferredSize: Size.fromHeight(60));
  }

  static TextFormField textField(
      {required String hintText,
      required TextEditingController editingController}) {
    return TextFormField(
        validator: (value) {
          return value!.isEmpty || value.length < 4
              ? "Not Sufficient Data"
              : null;
        },
        controller: editingController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white54),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ));
  }
}
