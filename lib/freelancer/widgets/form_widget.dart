import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import 'color_widget.dart';

// ignore: must_be_immutable
class FormWidget extends StatelessWidget {
  String label;
  String hintText;
  double sizeHeight;
  double sizeWidth;
  Color warna;
  FormWidget(this.label, this.hintText, this.sizeHeight, this.sizeWidth, this.warna, {super.key});

  TextEditingController formWidgetController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeHeight,
      width: sizeWidth,
      child: TextField(
        controller: formWidgetController,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Gfont.color(warna).bold,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}

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






// ignore: must_be_immutable
class FormWidget3 extends StatelessWidget {
  String label;
  String hintText;
  IconData icon;
  Color warna;
  double size;
  double sizeHeight;
  double sizeWidth;
  FormWidget3(this.label, this.hintText, this.icon, this.warna, this.size,this.sizeHeight,this.sizeWidth,{super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeHeight,
      width: sizeWidth,
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Gfont.color(warna).bold,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: IconButton(
            icon: Icon(icon, color: warna, size: size,),
            onPressed: () {
            }
        ).margin(r: 15),
      ),
    ));
  }
}