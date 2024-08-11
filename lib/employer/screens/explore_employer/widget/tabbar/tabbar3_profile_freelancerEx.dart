// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../../freelancer/widgets/color_widget.dart';

class Tabbar3ProfileFreelancerEx extends StatelessWidget {
  final skills;
  const Tabbar3ProfileFreelancerEx({super.key, this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: skills.isNotEmpty
              ? ListView.builder(
                  itemCount: skills.length,
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    String skillName = skill.skillName;
                    String description = skill.description;

                    return Container(
                      margin: Ei.only(b: 20, l: 25, r: 25),
                      height: 130,
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
                                skillName,
                                width: context.width / 2 - 50,
                                maxLines: 1,
                                overflow: Tof.ellipsis,
                                style: Gfont.color(color1).fsize(12),
                              ),
                            ],
                          ),
                          Textr(description,
                              style: Gfont.color(Colors.grey).fsize(12),
                              maxLines: 3,
                              overflow: Tof.ellipsis,
                              margin: Ei.only(r: 30)),
                        ],
                      ).margin(l: 15, r: 25),
                    );
                  },
                )
              : const LzNoData(
                  message:
                      'There is no data yet',
                  iconWidget:
                      Icon(Ti.alertTriangle, color: Colors.grey, size: 50))),
    ]);
  }
}
