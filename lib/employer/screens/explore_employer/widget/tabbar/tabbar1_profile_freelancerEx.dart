// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../../freelancer/widgets/color_widget.dart';

class Tabbar1ProfileFreelancerEx extends StatelessWidget {
  final experiences;
  const Tabbar1ProfileFreelancerEx({super.key, this.experiences});

  Widget build(BuildContext context) {
    return experiences.length > 0
        ? ListView.builder(
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              final experience = experiences[index];
              String title = experience.title ?? '';
              String description = experience.description ?? '';
              String startDate = experience.startDate.format('dd MMM yyyy');
              String endDate = experience.endDate.format('dd MMM yyyy');
              String company = experience.company ?? '';

              return Container(
                margin: Ei.only(b: 20, l: 25, r: 25),
                height: 140,
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
                          title,
                          style: Gfont.color(color1).fsize(12),
                          width: context.width / 2 - 40,
                          maxLines: 1,
                          overflow: Tof.ellipsis,
                        ),
                        Textr(
                          '$startDate - $endDate',
                          style: Gfont.color(LzColors.hex('000000')).fsize(10),
                        )
                      ],
                    ),
                    Textr(
                      company,
                      width: context.width / 2 - 50,
                      maxLines: 1,
                      overflow: Tof.ellipsis,
                      style: Gfont.color(black).fsize(12),
                      margin: Ei.only(t: 5, b: 5),
                    ),
                    Textr(
                      description,
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
              );
            },
          )
        : const LzNoData(
            message: 'There is no data yet',
          );
  }
}
