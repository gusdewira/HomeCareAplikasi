import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../data/models/setting/project_freelancer_model.dart';
import '../../../../providers/project/project_active_provider.dart';
import '../../../../providers/project/project_waiting_provider.dart';
import '../../../../routes/paths.dart';
import '../../../../widgets/color_widget.dart';

class Tabbar2 extends ConsumerWidget {
  const Tabbar2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(projectProgress);

    return Column(
      children: [
        Expanded(
          child: profileData.when(
            data: (List<ProjectFreelancerModel> projectProgreses) {
              return projectProgreses.isNotEmpty
                  ? ListView.builder(
                      itemCount: projectProgreses.length,
                      itemBuilder: (context, index) {
                        final projectProgress = projectProgreses[index];
                        String title = projectProgress.title!;
                        double startSalary = projectProgress.startSalary!;
                        double endSalary = projectProgress.endSalary!;
                        DateTime startDate = projectProgress.startDate!;
                        DateTime endDate = projectProgress.endDate!;

                        return Column(
                          children: [
                            Container(
                              padding: Ei.all(15),
                              margin: Ei.only(l: 25, r: 25, b: 20),
                              height: 200,
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
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Hired date: 12-04-2023',
                                      style: Gfont.color(color1)
                                          .fsize(12)
                                          .bold,
                                    ),
                                  ),
                                  Text(title,
                                          style: Gfont.color(color1)
                                              .fsize(15)
                                              .bold)
                                      .margin(b: 5),
                                  Text('Client : Galang Kangin Software',
                                      style: Gfont.color(color1).fsize(12)),
                                  Row(
                                    children: [
                                      Icon(
                                        Ti.coin,
                                        color: Colors.green,
                                      ).margin(r: 5),
                                      Textr(
                                        '$startSalary - $endSalary',
                                        style: Gfont.color(black).fsize(12),
                                      ),
                                    ],
                                  ).margin(t: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Ti.clock,
                                        color: Colors.red,
                                      ).margin(r: 5),
                                      Textr(
                                        '${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)}',
                                        style: Gfont.color(black).fsize(12),
                                        width: context.width / 3 + 10,
                                        maxLines: 1,
                                        overflow: Tof.ellipsis,
                                      ),
                                    ],
                                  ).margin(t: 5),
                                  Row(
                                    children: [
                                      InkTouch(
                                        onTap: () {
                                          context.push(
                                              Paths.sendProgressProject);
                                        },
                                        child: Container(
                                          margin: Ei.only(t: 20),
                                          height: 30,
                                          width: context.width / 3,
                                          decoration: BoxDecoration(
                                              color: LzColors.hex('006FFF'),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20)),
                                          child: Center(
                                              child: Textr(
                                            'Send progress project',
                                            style: Gfont.white.fsize(10),
                                          )),
                                        ),
                                      ),
                                      InkTouch(
                                        onTap: () {
                                          context.push(Paths.historyProgress);
                                        },
                                        child: Container(
                                          margin: Ei.only(t: 20, l: 10),
                                          height: 30,
                                          width: context.width / 3,
                                          decoration: BoxDecoration(
                                              color: LzColors.hex('006FFF'),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20)),
                                          child: Center(
                                              child: Textr(
                                            'History Progress',
                                            style: Gfont.white.fsize(10),
                                          )),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkTouch(
                                            margin: Ei.only(t: 15, l: 20),
                                            onTap: () {
                                              context.push(Paths
                                                  .detailProgressProject);
                                            },
                                            child: Icon(
                                              Ti.infoCircle,
                                              size: 25,
                                              color: LzColors.hex('0047E3'),
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : const LzNoData(
                      message:
                          'No offers were accepted');
            },
            error: (error, _) {
              ref.read(projectBid.notifier).getProjectBid();
              return LzNoData(message: 'Oops! $error');
            },
            loading: () {
              return LzLoader.bar(message: 'Loading...');
            },
          ),
        ),
      ],
    );
  }
}
