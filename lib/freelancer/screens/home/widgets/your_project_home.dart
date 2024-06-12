import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';

class YourProjectHome extends StatelessWidget {
  const YourProjectHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: context.width / 1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
            )
          ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: Caa.start,
            mainAxisAlignment: Maa.spaceBetween,
            children: [
              Text(
                'Your Projects',
                style: Gfont.color(LzColors.hex('2A1E17')).fsize(16),
              ),
              InkTouch(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: color1)),
                  child: Center(
                    child: Text(
                      'View all project',
                      style: Gfont.color(color1).fsize(12),
                    ),
                  ),
                ),
              )
            ],
          ).margin(l: 15, r: 15, t: 15, b: 15),
          Container(
            margin: Ei.only(l: 5, r: 5),
            width: context.width,
            height: 2,
            color: Colors.black12,
          ),
          Container(
            padding: Ei.only(l: 15, r: 15, t: 15),
            child: Row(
              mainAxisAlignment: Maa.spaceBetween,
              children: [
                Text(
                  'Russian Preschool',
                  style: Gfont.color(LzColors.hex('000000')).bold.fsize(13),
                ),
                Text('10/04/2023 - 21/04/2023 ',
                    style: Gfont.color(LzColors.hex('000000')).fsize(12))
              ],
            ),
          ),
          Textr(
            'salary 200k-1200k',
            style: Gfont.fs13,
            alignment: Alignment.topLeft,
            margin: Ei.only(l: 15),
          ),
          Container(
            padding: Ei.only(l: 15, r: 15, t: 15),
            child: Row(
              mainAxisAlignment: Maa.spaceBetween,
              children: [
                Text(
                  'Russian Preschool',
                  style: Gfont.color(LzColors.hex('000000')).bold.fsize(13),
                ),
                Text('10/04/2023 - 21/04/2023 ',
                    style: Gfont.color(LzColors.hex('000000')).fsize(12))
              ],
            ),
          ),
          Textr(
            'salary 200k-1200k',
            style: Gfont.fs13,
            alignment: Alignment.topLeft,
            margin: Ei.only(l: 15),
          )
        ],
      ),
    );
  }
}
