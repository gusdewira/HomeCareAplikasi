import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class FormRegist extends StatelessWidget {
  final String text1;
  final String text2;
    const FormRegist({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Ei.only(t: 30),
      child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Text(text1, style: Gfont.bold,)),
            TextFormField(
              decoration: InputDecoration(
                hintText: text2 ,
                border: OutlineInputBorder(
                  borderRadius:
                    BorderRadius.circular(10),
                ),
                contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
            ),
          ],
        ),
    );

  }
}
