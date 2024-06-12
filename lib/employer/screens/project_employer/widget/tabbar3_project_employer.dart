import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class Tabbar3ProjectEmployer extends StatelessWidget {
  const Tabbar3ProjectEmployer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: Ei.only(l: 20, r: 20, t: 10),
          margin: Ei.only(l: 25, r: 25, b: 20, t: 20),
          height: 235,
          width: context.width / 1,
          decoration: BoxDecoration(
              color: LzColors.hex('FFFFFF'),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                )
              ]),
          child: Column(
            mainAxisSize: Mas.min,
            crossAxisAlignment: Caa.start,
            children: [
              
            ],
          ),
        ),
      ],
    );
  }
}