import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

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