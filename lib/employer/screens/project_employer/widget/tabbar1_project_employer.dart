import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

class Tabbar1ProjectEmployer extends StatelessWidget {
  const Tabbar1ProjectEmployer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: Ei.only(l: 20, r: 20, t: 10),
            margin: Ei.only(l: 25, r: 25, b: 20, t: 20),
            height: 235,
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
                Container(
                  width: context.width,
                  child: Text(
                    maxLines: 1,
                    overflow: Tof.ellipsis,
                    'EcoSolutions Waste Management Pilot',
                    style: Gfont.color(LzColors.hex('001380')).fsize(18),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: Caa.start,
                        children: [
                          Textr(margin: Ei.only(r: 10), 'Salary'),
                          Textr(margin: Ei.only(r: 10), '400k - 500k', style: Gfont.color(LzColors.hex('001380'))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: Caa.start,
                        children: [
                          Textr(
                              maxLines: 1,
                              overflow: Tof.ellipsis,
                              'duration'),
                          Textr(
                              alignment: Alignment.center,
                              maxLines: 1,
                              overflow: Tof.ellipsis,
                              '24/08/23 - 24/08/24',style: Gfont.color(LzColors.hex('001380'))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: Maa.end,
                            children: [
                              Icon(Ti.mapPin),
                              Textr(
                                  alignment: Alignment.centerRight,
                                  margin: Ei.only(r: 10),
                                  'Denpasar', style: Gfont.color(LzColors.hex('001380'))),
                            ],
                          ),
                          Textr(
                              alignment: Alignment.center,
                              maxLines: 1,
                              overflow: Tof.ellipsis,
                              ''),
                        ],
                      ),
                    ),
                  ],
                ).margin(t: 10),
                Textr(
                    margin: Ei.only(t: 10),
                    maxLines: 3,
                    overflow: Tof.ellipsis,
                    'The EcoSolutions Waste Management Pilot aims to implement an innovative waste management system that emphasizes ..view more'),
                InkTouch(
                  onTap: () {
                    context.push(Paths.seeRequestEmployer);
                  },
                  child: SizedBox(
                    width: context.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                            color: LzColors.hex('0047E3'),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Textr(
                            alignment: Alignment.center,
                            'See Request',
                            style: Gfont.color(LzColors.hex('ffffff')).fsize(12),
                          ),
                        ),
                      ],
                    ).margin(t: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
          margin: Ei.only(r: 25, b: 25),
          child: FloatingActionButton(
            onPressed: () {
              context.push(Paths.postingProjectEmployer);
            },
            backgroundColor: color1,
            child: const Icon(
              Ti.plus,
              size: 30,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
