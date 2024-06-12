
import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'color_widget.dart';

// ignore: must_be_immutable
class FormWidget2 extends StatelessWidget {
  String label;
  String hintText;
  double height1;
  FormWidget2(this.label, this.hintText, this.height1, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Ei.only(b: 20),
      height: height1,
      width: context.width,
      child: TextField(
        expands: true,
        minLines: null,
        maxLines: null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Gfont.color(color1).bold,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: Ei.sym(v: 30, h: 10),
        ),
      ),
    );
  }
}