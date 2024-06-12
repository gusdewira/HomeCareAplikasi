// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../../freelancer/widgets/color_widget.dart';

class Tabbar2ProfileFreelancerEx extends StatelessWidget {
  const Tabbar2ProfileFreelancerEx({super.key});

  @override
  Widget build(BuildContext context) {
    return LzListView(
      children: [
        Container(
          height: 145,
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
              Row(
                mainAxisAlignment: Maa.spaceBetween,
                children: [
                  Textr(
                    'title',
                    style: Gfont.color(color1).fsize(12),
                  ),
                  Textr(
                    'date',
                    style: Gfont.color(LzColors.hex('000000')).fsize(10),
                  )
                ],
              ),
              Textr(
                'orgQualification',
                width: context.width / 2 - 50,
                margin: Ei.only(t: 10, b: 10),
                maxLines: 1,
                overflow: Tof.ellipsis,
                style: Gfont.color(black).fsize(12),
              ),
              Container(
                margin: Ei.only(t: 10),
                padding: Ei.all(8),
                height: 40,
                width: context.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(width: 1, color: LzColors.hex('9B9B9B'))),
                child: Row(
                  mainAxisAlignment: Maa.spaceBetween,
                  children: [
                    Textr(
                      'attchment',
                      style: Gfont.color(LzColors.hex('A9A6CD')).fsize(15),
                      width: 200,
                    ),
                    InkTouch(
                      onTap: () {},
                      child: Container(
                        padding: Ei.all(5),
                        decoration: BoxDecoration(
                            color: LzColors.hex('FFD700'),
                            borderRadius: BorderRadius.circular(5)),
                        child: Textr(
                          'Download',
                          style: Gfont.color(LzColors.hex('000000')).fsize(10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ).margin(l: 15, r: 25, t: 15),
        ),
      ],
    );
  }
}
