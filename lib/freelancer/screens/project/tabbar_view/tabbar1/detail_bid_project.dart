import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../data/models/setting/project_freelancer_model.dart';

class DetailBidProject extends ConsumerWidget {
  final ProjectFreelancerModel? projectBid;
  const DetailBidProject({super.key, this.projectBid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
      child: ListView(
        children: [
          Stack(
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
                    'Detail Project',
                    style: Gfont.white.bold.fsize(18),
                  ))),
              Positioned(
                left: 25,
                right: 25,
                top: 160,
                child: Column(
                  mainAxisSize: Mas.min,
                  crossAxisAlignment: Caa.start,
                  children: [
                    Textr('Project Title',
                        style:
                            Gfont.color(LzColors.hex('231E55')).fsize(15).bold),
                    Textr(
                      projectBid!.title!,
                      style: Gfont.color(LzColors.hex('595959')).fsize(13),
                      margin: Ei.only(t: 5),
                      width: context.width,
                      maxLines: 2,
                    ),
                    Textr(
                      'Project Description',
                      style: Gfont.color(LzColors.hex('231E55')).fsize(15).bold,
                      margin: Ei.only(t: 20),
                    ),
                    Textr(
                      projectBid!.description!,
                      style: Gfont.color(LzColors.hex('595959')).fsize(13),
                      margin: Ei.only(t: 5),
                      width: 350,
                    ),
                    Textr(
                      'Skills',
                      style: Gfont.color(LzColors.hex('231E55')).fsize(15).bold,
                      margin: Ei.only(t: 20),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: Ei.only(r: 5),
                          padding: Ei.all(8),
                          decoration: BoxDecoration(
                              color: LzColors.hex('94BDFF'),
                              borderRadius: BorderRadius.circular(5)),
                          child: Textr(
                            'Frontend',
                            style:
                                Gfont.color(LzColors.hex('000000')).fsize(13),
                          ),
                        ),
                      ],
                    ).margin(t: 10),
                    Textr(
                      'Salary',
                      style: Gfont.color(LzColors.hex('231E55')).fsize(15).bold,
                      margin: Ei.only(t: 20),
                    ),
                    Textr(
                      '${projectBid!.startSalary} - ${projectBid!.endSalary}',
                      style: Gfont.color(LzColors.hex('595959')).fsize(13),
                      margin: Ei.only(t: 5),
                      width: 350,
                    ),
                    Textr(
                      'Attachment',
                      style: Gfont.color(LzColors.hex('231E55')).fsize(15).bold,
                      margin: Ei.only(t: 20),
                    ),
                    Container(
                      margin: Ei.only(t: 10),
                      padding: Ei.all(10),
                      height: 40,
                      width: context.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1, color: LzColors.hex('9B9B9B'))),
                      child: Row(
                        mainAxisAlignment: Maa.spaceBetween,
                        children: [
                          Expanded(
                            child: Textr(
                              projectBid!.attachment!,
                              style:
                                  Gfont.color(LzColors.hex('A9A6CD')).fsize(15),
                            ),
                          ),
                          Container(
                            padding: Ei.all(3),
                            decoration: BoxDecoration(
                                color: LzColors.hex('FFD700'),
                                borderRadius: BorderRadius.circular(5)),
                            child: Textr(
                              'Download',
                              style:
                                  Gfont.color(LzColors.hex('000000')).fsize(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Textr(
                      'Estimated Duration',
                      style: Gfont.color(LzColors.hex('231E55')).fsize(15).bold,
                      margin: Ei.only(t: 20, b: 5),
                    ),
                    Textr(
                      '22/09/2023 - 31/12/2023',
                      style: Gfont.color(LzColors.hex('A9A6CD')).fsize(13),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
