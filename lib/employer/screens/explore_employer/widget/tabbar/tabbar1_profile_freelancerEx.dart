// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../../freelancer/widgets/color_widget.dart';

class Tabbar1ProfileFreelancerEx extends StatelessWidget {
  const Tabbar1ProfileFreelancerEx({super.key});

  @override
  Widget build(BuildContext context) {
    return LzListView(
      children: [
        Container(
          height: 100,
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
            ],
          ),
          child: Column(
            mainAxisSize: Mas.min,
            crossAxisAlignment: Caa.start,
            children: [
              Row(
                mainAxisAlignment: Maa.spaceBetween,
                children: [
                  Textr(
                    'title',
                    style: Gfont.color(color1).fsize(12),
                    width: context.width / 2 - 40,
                    maxLines: 1,
                    overflow: Tof.ellipsis,
                  ),
                  Textr(
                    'date',
                    style: Gfont.color(LzColors.hex('000000')).fsize(10),
                  )
                ],
              ),
              Textr(
                'company',
                width: context.width / 2 - 50,
                maxLines: 1,
                overflow: Tof.ellipsis,
                style: Gfont.color(black).fsize(12),
                margin: Ei.only(t: 5, b: 5),
              ),
              Textr(
                'description',
                style: Gfont.color(Colors.grey).fsize(12),
                maxLines: 4,
                overflow: Tof.ellipsis,
                margin: Ei.only(r: 30),
              ),
            ],
          ).margin(
            l: 15,
            r: 25,
            t: 15,
          ),
        ),
      ],
    );
  }
}
