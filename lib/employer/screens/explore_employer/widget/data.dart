import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:lazyui/lazyui.dart';

class DataExploreFreelancer extends StatelessWidget {
  final ProjectEmployerModel projectEmployee;
  const DataExploreFreelancer({super.key, required this.projectEmployee});

  @override
  Widget build(BuildContext context) {
    String formatNumber(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return number.toStringAsFixed(0);
    }}

    final name = '${projectEmployee.user!["first_name"]!} ${projectEmployee.user!["last_name"]!}';

    return InkTouch(
      onTap: () {
        context.push(Paths.profileFreelancerEx);
      },
      child: Container(
        padding: Ei.only(l: 20, r: 20, t: 10),
        margin: Ei.only(l: 25, r: 25, b: 20, t: 20),
        width: context.width / 1,
        height: 220,
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
              children: [
                const LzImage(
                  'profile.jpg',
                  radius: 40,
                  size: 50,
                ),
                Expanded(
                  child: Container(
                    margin: Ei.only(l: 10),
                    width: context.width,
                    height: 50,
                    child: Row(
                      crossAxisAlignment: Caa.start,
                      mainAxisAlignment: Maa.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Textr(name,
                                width: 150,
                                overflow: Tof.ellipsis,
                                style: Gfont.color(LzColors.hex('001380'))),
                            Textr('${projectEmployee.user!['profession'] ?? "Employer"}',
                                overflow: Tof.ellipsis,
                                width: 150,
                                style: Gfont.color(LzColors.hex('B9B9B9'))),
                          ],
                        ),
                        Column(
                          children: [
                            Textr('${formatNumber(projectEmployee.startSalary!)} ${formatNumber(projectEmployee.endSalary!)}',
                                overflow: Tof.ellipsis,
                                width: 100,
                                style: Gfont.color(LzColors.hex('001380'))),
                            SizedBox(
                              width: 100,
                              child: Container(
                                margin: Ei.only(l: 5),
                                width: 100,
                                child: Row(
                                  children: [
                                    Icon(
                                      Ti.mapPin,
                                      color: LzColors.hex('001380'),
                                      size: 15,
                                    ),
                                    Text(projectEmployee.user!['address'],
                                        overflow: Tof.ellipsis,
                                        style:
                                            Gfont.color(LzColors.hex('001380'))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Textr(
              margin: Ei.only(t: 10),
              maxLines: 4,
              projectEmployee.description!,
              style: Gfont.color(LzColors.hex('747474')).fsize(14),
            ),
            SizedBox(
              width: context.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkTouch(
                    onTap: () {

                    },
                    child: Container(
                      margin: Ei.only(r: 10),
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: LzColors.hex('0047E3'), width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: Maa.center,
                        children: [
                          Icon(
                            Ti.message,
                            color: LzColors.hex('0047E3'),
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Textr(
                            alignment: Alignment.center,
                            'chat',
                            style: Gfont.color(LzColors.hex('0047E3')),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: LzColors.hex('0047E3'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Textr(
                      alignment: Alignment.center,
                      'see detail',
                      style: Gfont.color(LzColors.hex('ffffff')).fsize(12),
                    ),
                  ),
                ],
              ).margin(t: 15),
            )
          ],
        ),
      ),
    );
  }
}
