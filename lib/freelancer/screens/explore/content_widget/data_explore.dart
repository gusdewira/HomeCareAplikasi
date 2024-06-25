import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:homecare_app/freelancer/screens/explore/content_widget/detail_project_explore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/project_freelancer_model.dart';
import '../../../providers/explore/project_freelancer_provider.dart';
import '../../../widgets/color_widget.dart';
import 'bid_explore.dart';

class DataExplore extends ConsumerWidget {
  const DataExplore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectFreelancer);

    return RefreshIndicator(
      onRefresh: ()async{
        ref.read(projectFreelancer.notifier);
      },
      child: Column(
        children: [
          Expanded(
            child: project.when(
              data: (List<ProjectFreelancerModel> projectFreelancers) {
                return projectFreelancers.isNotEmpty
                    ? ListView.builder(
                        itemCount: projectFreelancers.length,
                        itemBuilder: (context, index) {
                          final projectFreelancer = projectFreelancers[index];
                          String title = projectFreelancer.title!;
                          String description = projectFreelancer.description!;
                          double startSalary = projectFreelancer.startSalary!;
                          double endSalary = projectFreelancer.endSalary!;
                          DateTime startDate = projectFreelancer.startDate!;
                          DateTime endDate = projectFreelancer.endDate!;

                          return Container(
                            padding: Ei.only(l: 20, r: 20, t: 10),
                            margin: Ei.only(l: 25, r: 25, b: 20),
                            height: 250,
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
                                          style: Gfont.color(color1).bold.fsize(16),
                                          margin: Ei.only(r: 30),
                                          width: context.width,
                                          maxLines: 1,
                                          overflow: Tof.ellipsis,
                                        ),
                                      ),
                                      InkTouch(
                                          onTap: () {
                                            context.lzPush(DetailProjectExplore(data: projectFreelancer,));
                                          },
                                          child: Icon(
                                            Ti.infoCircle,
                                            size: 25,
                                            color: LzColors.hex('0047E3'),
                                          ))
                                    ],
                                  ),
                                ),
                                Text('posted 1 hours', style: Gfont.color(LzColors.hex('747474')).fsize(12),).margin(t: 5, b: 5),
                                SizedBox(
                                    width: context.width,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Ti.coin,
                                              color: Colors.green,
                                            ).margin(r: 5),
                                            Textr(
                                              '$startSalary - $endSalary',
                                              style: Gfont.color(
                                                      black)
                                                  .fsize(12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Ti.clock,
                                              color: Colors.red,
                                            ).margin(r: 5),
                                            Textr(
                                              '${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)}',
                                              style: Gfont.color(
                                                      black)
                                                  .fsize(12),
                                              width: context.width / 3+10,
                                              maxLines: 1,
                                              overflow: Tof.ellipsis,
                                            ),
                                          ],
                                        ).margin(t: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Ti.mapPin,
                                              color: color1,
                                            ).margin(r: 5),
                                            Textr(
                                              'Galkasoft',
                                              style: Gfont.color(
                                                      black)
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
                                  style: Gfont.color(black)
                                      .fsize(12),
                                  margin: Ei.only(t: 10),
                                  maxLines: 3,
                                  overflow: Tof.ellipsis,
                                ),
                                Flexible(
                                  child: InkTouch(
                                    onTap: () {
                                      context.lzPush(BidExplore(data: projectFreelancer));
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: Ei.only(t: 10, b: 20),
                                        height: 30,
                                        width: context.width,
                                        decoration: BoxDecoration(
                                            color: color1,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                            child: Text(
                                          'Bid Project',
                                          style: Gfont.white.bold.fsize(12),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const LzNoData(
                        message:
                            'There is no data yet, please add data in the add profileFreelancers menu');
              },
              error: (error, _) {
                // ref.read(projectFreelancer.notifier).getProjectFreelancer();
                return LzNoData(message: 'Oops! $error');
              },
              loading: () {
                return LzLoader.bar(message: 'Loading...');
              },
            ),
          ),
        ],
      ),
    );
  }
}
