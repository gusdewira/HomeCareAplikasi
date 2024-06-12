import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../data/models/explore/project_freelancer_model.dart';
import '../../../../providers/project/project_waiting_provider.dart';
import '../../../../routes/paths.dart';
import '../../../../widgets/color_widget.dart';

class Tabbar1 extends ConsumerWidget {
  const Tabbar1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(projectBid);

    return Column(
      children: [
        Expanded(
          child: profileData.when(
            data: (List<ProjectFreelancerModel> projectBids) {
              return projectBids.isNotEmpty
                  ? ListView.builder(
                      itemCount: projectBids.length,
                      itemBuilder: (context, index) {
                        final projectBid = projectBids[index];
                        String title = projectBid.title;
                        String description = projectBid.description;
                        String startSalary = projectBid.startSalary;
                        String endSalary = projectBid.endSalary;
                        DateTime startDate = projectBid.startDate;
                        DateTime endDate = projectBid.endDate;

                        return Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: Ei.only(l: 20, r: 20, t: 10),
                                  margin: Ei.only(l: 25, r: 25, b: 20),
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
                                      SizedBox(
                                        width: context.width,
                                        height: 20,
                                        child: Row(
                                          mainAxisSize: Mas.min,
                                          mainAxisAlignment: Maa.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Textr(
                                                title,
                                                style: Gfont.color(color1)
                                                    .bold
                                                    .fsize(16),
                                                margin: Ei.only(r: 30),
                                                width: context.width,
                                                maxLines: 1,
                                                overflow: Tof.ellipsis,
                                              ),
                                            ),
                                            InkTouch(
                                                onTap: () {
                                                  context.push(
                                                      Paths.detailBidProject);
                                                },
                                                child: Icon(
                                                  Ti.infoCircle,
                                                  size: 25,
                                                  color: LzColors.hex('0047E3'),
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          width: context.width,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Ti.coin,
                                                    color: Colors.green,
                                                  ).margin(r: 5),
                                                  Textr(
                                                    '$startSalary - $endSalary',
                                                    style: Gfont.color(black)
                                                        .fsize(12),
                                                  ),
                                                ],
                                              ).margin(t: 10),
                                              Row(children: [
                                                Icon(
                                                  Ti.clock,
                                                  color: Colors.red,
                                                ).margin(r: 5),
                                                Textr(
                                                  '${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)}',
                                                  style: Gfont.color(black)
                                                      .fsize(12),
                                                  width: context.width / 3 + 10,
                                                  maxLines: 1,
                                                  overflow: Tof.ellipsis,
                                                ),
                                              ]).margin(t: 5),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Ti.mapPin,
                                                    color: color1,
                                                  ).margin(r: 5),
                                                  Textr(
                                                    'Galkasoft',
                                                    style: Gfont.color(black)
                                                        .fsize(12),
                                                    width: context.width / 3,
                                                    maxLines: 1,
                                                    overflow: Tof.ellipsis,
                                                  ),
                                                ],
                                              ).margin(t: 5)
                                            ],
                                          )),
                                      Textr(
                                        description,
                                        style:
                                            Gfont.color(LzColors.hex('747474'))
                                                .fsize(12),
                                        margin: Ei.only(t: 10),
                                        maxLines: 3,
                                        overflow: Tof.ellipsis,
                                      ),
                                      Container(
                                        margin: Ei.only(t: 15),
                                        width: 70,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.orangeAccent,
                                        ),
                                        child: Textr(
                                          'Waiting',
                                          style: Gfont.white.bold.fsize(15),
                                          alignment: Alignment.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    )
                  : const LzNoData(
                      message:
                          'You don\'t have an offer yet');
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
