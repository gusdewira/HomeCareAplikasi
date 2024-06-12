import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../widgets/color_widget.dart';

class HistoryProgress extends StatelessWidget {
  const HistoryProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                LzColors.hex('11B0E6'),
                LzColors.hex('3265FF'),
              ],
              stops: const [
                0.0,
                0.6
              ]),
        ),
        child: Stack(
          children: [
            Container(
              margin: Ei.only(t: 120),
              width: context.width,
              height: context.height,
              decoration: BoxDecoration(
                  color: LzColors.hex('F8F8FF'),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
            ),
            Positioned(
              top: 50,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Ti.chevronLeft,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Center(
                    child: Textr(
                  'History Progress',
                  style: Gfont.white.bold.fsize(18),
                ))),
            Column(
              children: [
                Container(
                  height: 160,
                  width: context.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2, color: Colors.black12)),
                  child: Column(
                    crossAxisAlignment: Caa.start,
                    children: [
                      Row(
                        crossAxisAlignment: Caa.start,
                        children: [
                          const LzImage(
                            'profile.jpg',
                            radius: 50,
                            size: 50,
                          ).margin(t: 10),
                          Column(
                            crossAxisAlignment: Caa.start,
                            children: [
                              Textr(
                                'SmartCity Infrastructure Upgrade',
                                style: Gfont.color(color1).fsize(12).bold,
                                margin: Ei.only(b: 5),
                                width: context.width / 2 -10,
                                maxLines: 2,
                                overflow: Tof.ellipsis,
                              ),
                              Textr(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the',
                                margin: Ei.only(b: 10),
                                style: Gfont.fs10,
                                width: context.width / 2,
                                overflow: Tof.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ).margin(l: 10)
                        ],
                      ).margin(l: 10, t: 10),
                      Container(
                        margin: Ei.only(l: 15, r: 15, t: 10),
                        height: 40,
                        width: context.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(width: 2, color: Colors.black12)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: Maa.spaceBetween,
                            children: [
                              Textr(
                                'attachment.pdf',
                                margin: Ei.only(l: 10),
                                style: Gfont.fs13,
                              ),
                              InkTouch(
                                onTap: () {},
                                child: Container(
                                  margin: Ei.only(r: 15),
                                  padding: Ei.all(6),
                                  decoration: BoxDecoration(
                                      color: LzColors.hex('FFD700'),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Textr(
                                    'Download',
                                    style: Gfont.color(LzColors.hex('000000'))
                                        .fsize(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ).margin(l: 25, r: 25, t: 150)
          ],
        ));
  }
}
