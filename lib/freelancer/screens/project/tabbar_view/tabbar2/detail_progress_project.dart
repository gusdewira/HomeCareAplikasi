import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class DetailProgressProject extends StatelessWidget {
  const DetailProgressProject({super.key});

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
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu est sed dui vulputate porttitor sit amet ut neque. ',
                      style: Gfont.color(LzColors.hex('595959')).fsize(13),
                      margin: Ei.only(t: 5),
                      width: 350,
                    ),
                    Textr(
                      'Project Description',
                      style: Gfont.color(LzColors.hex('231E55')).fsize(15).bold,
                      margin: Ei.only(t: 20),
                    ),
                    Textr(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu est sed dui vulputate porttitor sit amet ut neque. ',
                      style: Gfont.color(LzColors.hex('595959')).fsize(13),
                      margin: Ei.only(t: 5),
                      width: 350,
                    ),
                    Textr(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu est sed dui vulputate porttitor sit amet ut neque. ',
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
                        Container(
                          margin: Ei.only(r: 5),
                          padding: Ei.all(8),
                          decoration: BoxDecoration(
                              color: LzColors.hex('94BDFF'),
                              borderRadius: BorderRadius.circular(5)),
                          child: Textr(
                            'Backend',
                            style:
                                Gfont.color(LzColors.hex('000000')).fsize(13),
                          ),
                        ),
                        Container(
                          margin: Ei.only(r: 5),
                          padding: Ei.all(8),
                          decoration: BoxDecoration(
                              color: LzColors.hex('94BDFF'),
                              borderRadius: BorderRadius.circular(5)),
                          child: Textr(
                            'System Analyst',
                            style:
                                Gfont.color(LzColors.hex('000000')).fsize(13),
                          ),
                        ),
                        Container(
                          padding: Ei.all(8),
                          decoration: BoxDecoration(
                              color: LzColors.hex('94BDFF'),
                              borderRadius: BorderRadius.circular(5)),
                          child: Textr(
                            'UI/UX',
                            style:
                                Gfont.color(LzColors.hex('000000')).fsize(13),
                          ),
                        )
                      ],
                    ).margin(t: 10),
                    Textr(
                      'Salary',
                      style: Gfont.color(LzColors.hex('231E55')).fsize(15).bold,
                      margin: Ei.only(t: 20),
                    ),
                    Textr(
                      '120k - 250k',
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
                          Textr(
                            'attachment.pdf',
                            style:
                                Gfont.color(LzColors.hex('A9A6CD')).fsize(15),
                          ),
                          Container(
                            padding: Ei.only(l: 5, r: 5,),
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
                      margin: Ei.only(t: 20),
                    ),
                    Container(
                      margin: Ei.only(t: 10),
                      padding: Ei.all(12),
                      height: 40,
                      width: context.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1, color: LzColors.hex('9B9B9B'))),
                      child: Textr(
                        '22/09/2023 - 31/12/2023',
                        style: Gfont.color(LzColors.hex('A9A6CD')).fsize(13),
                      ),
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