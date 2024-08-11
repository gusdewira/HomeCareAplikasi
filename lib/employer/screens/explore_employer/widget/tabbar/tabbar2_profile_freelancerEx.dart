// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../../freelancer/widgets/color_widget.dart';

class Tabbar2ProfileFreelancerEx extends StatelessWidget {
  final qualifications;
  const Tabbar2ProfileFreelancerEx({super.key, this.qualifications});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: qualifications.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: qualifications.length,
                    itemBuilder: (context, index) {
                      final qualification = qualifications[index];
                      int? id = qualification.id;
                      String title = qualification.title;
                      String orgQualification = qualification.orgQualification;
                      String date = qualification.date.format('dd MMM yyyy');
                      String attchment = qualification.attachment;

                      return Container(
                        margin: Ei.only(l: 25, r: 25, b: 20),
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
                                  title,
                                  style: Gfont.color(color1).fsize(12),
                                ),
                                Textr(
                                  date,
                                  style: Gfont.color(LzColors.hex('000000'))
                                      .fsize(10),
                                )
                              ],
                            ),
                            Container(
                              margin: Ei.only(t: 10),
                              padding: Ei.all(8),
                              height: 40,
                              width: context.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: LzColors.hex('9B9B9B'))),
                              child: Row(
                                mainAxisAlignment: Maa.spaceBetween,
                                children: [
                                  Textr(
                                    attchment,
                                    style: Gfont.color(LzColors.hex('A9A6CD'))
                                        .fsize(15),
                                    width: 200,
                                  ),
                                  InkTouch(
                                    onTap: () {},
                                    child: Container(
                                      padding: Ei.all(5),
                                      decoration: BoxDecoration(
                                          color: LzColors.hex('FFD700'),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Textr(
                                        'Download',
                                        style:
                                            Gfont.color(LzColors.hex('000000'))
                                                .fsize(10),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ).margin(l: 15, r: 25, t: 15),
                      );
                    },
                  )
                : const LzNoData(
                    message:
                        'There is no data yet',
                    iconWidget:
                        Icon(Ti.alertTriangle, color: Colors.grey, size: 50))),
      ],
    );
  }
}
