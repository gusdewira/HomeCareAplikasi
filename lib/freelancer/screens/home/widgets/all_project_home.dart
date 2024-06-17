import 'package:flutter/material.dart';
import 'package:homecare_app/freelancer/data/models/setting/project_freelancer_model.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';

class AllProjectHome extends StatelessWidget {
  final int? projects;
  final int? active;
  final int? completed;
  final int? rejected;

  const AllProjectHome({super.key, required this.projects, required this.active, this.completed, this.rejected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Ei.only(t: 10),
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
                'All Project',
                style: Gfont.color(LzColors.hex('2A1E17')).fsize(16),
              ),
              Row(
                children: [
                  Text(
                    'Total',
                    style: Gfont.fs18,
                  ).margin(r: 5),
                  Text(
                    '$projects',
                    style: Gfont.bold.fsize(16),
                  ),
                ],
              ),
            ],
          ).margin(l: 15, r: 15, t: 15, b: 15),
          Container(
            margin: Ei.only(l: 5, r: 5),
            width: context.width,
            height: 2,
            color: Colors.black12,
          ),
          Column(
            children: [
              Row(
                children: [
                  Iconr(
                    Ti.folderCheck,
                    color: LzColors.hex('10C623'),
                    size: 20,
                    margin: Ei.only(r: 5),
                  ),
                  Text(
                    'Active projects : ',
                    style: Gfont.color(LzColors.hex('2A1E17')).bold,
                  ),
                  Text(
                    '$active',
                    style: Gfont.color(LzColors.hex('2A1E17')),
                  ),
                ],
              ).margin(l: 10, t: 10),
              Row(
                children: [
                  Iconr(
                    Ti.cloudCheck,
                    color: color1,
                    size: 20,
                    margin: Ei.only(r: 5),
                  ),
                  Text(
                    'Completed projects : ',
                    style: Gfont.color(LzColors.hex('2A1E17')).bold,
                  ),
                  Text(
                    '$completed',
                    style: Gfont.color(LzColors.hex('2A1E17')),
                  ),
                ],
              ).margin(l: 10, t: 15),
              Row(
                children: [
                  Iconr(
                    Ti.squareLetterX,
                    color: LzColors.hex('FF4C4A'),
                    size: 20,
                    margin: Ei.only(r: 5),
                  ),
                  Text(
                    'Rejected projects : ',
                    style: Gfont.color(LzColors.hex('2A1E17')).bold,
                  ),
                  Text(
                    '$rejected',
                    style: Gfont.color(LzColors.hex('2A1E17')),
                  ),
                ],
              ).margin(l: 10, t: 15)
            ],
          )
        ],
      ),
    );
  }
}
