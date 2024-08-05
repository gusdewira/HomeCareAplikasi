import 'package:flutter/material.dart';

import 'package:homecare_app/freelancer/screens/explore/content_widget/detail_project_explore.dart';
import 'package:homecare_app/freelancer/screens/project/tabbar_view/tabbar2/history_progress_project.dart';
import 'package:homecare_app/freelancer/screens/project/tabbar_view/tabbar2/send_progres.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
// Pastikan Anda menambahkan ini untuk DateFormat

import '../../../../data/models/setting/project_freelancer_model.dart';
import '../../../../providers/project/project_active_provider.dart';
import '../../../../widgets/color_widget.dart';

class Tabbar2 extends ConsumerWidget {
  const Tabbar2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAccepts = ref.watch(projectProgress);

    Future<void> refreshProjects() async {
      await ref.refresh(projectProgress.notifier).getProjectProgress();
    }

    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    return Column(
      children: [
        Expanded(
          child: projectAccepts.when(
            data: (List<ProjectFreelancerModel> projectProgreses) {
              return projectProgreses.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: refreshProjects,
                      child: ListView.builder(
                        itemCount: projectProgreses.length,
                        itemBuilder: (context, index) {
                          final projectProgress = projectProgreses[index];
                          int idProject = projectProgress.id!;
                          String title = projectProgress.title!;
                          double startSalary = projectProgress.startSalary!;
                          double endSalary = projectProgress.endSalary!;
                          DateTime startDate = projectProgress.startDate!;
                          DateTime endDate = projectProgress.endDate!;
                          String client =
                              '${projectProgress.user!['first_name']} ${projectProgress.user!['last_name']}';
                          DateTime hireDate = projectProgress.createdAt!;
                          int idOffers = projectProgress.offer![0]["id"];

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
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: Mas.min,
                                  crossAxisAlignment: Caa.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'Hired Date : ${DateFormat('dd-MM-yyyy').format(hireDate)}',
                                        style:
                                            Gfont.color(color1).fsize(12).bold,
                                      ),
                                    ),
                                    Text(
                                      title,
                                      style: Gfont.color(color1).fsize(15).bold,
                                    ).margin(b: 5),
                                    Text(
                                      'Client : $client $idProject',
                                      style: Gfont.color(color1).fsize(12),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Ti.coin,
                                          color: Colors.green,
                                        ).margin(r: 5),
                                        Textr(
                                          '${formatNumber(startSalary)} - ${formatNumber(endSalary)}',
                                          style: Gfont.color(black).fsize(12),
                                        ),
                                      ],
                                    ).margin(t: 10),
                                    Row(
                                      children: [
                                        const Icon(
                                          Ti.clock,
                                          color: Colors.red,
                                        ).margin(r: 5),
                                        Textr(
                                          '${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)}',
                                          style: Gfont.color(black).fsize(12),
                                          width: context.width / 3 + 30,
                                          maxLines: 1,
                                          overflow: Tof.ellipsis,
                                        ),
                                      ],
                                    ).margin(t: 5),
                                    Row(
                                      children: [
                                        InkTouch(
                                          onTap: () {
                                            context.lzPush(SendProgressProject(
                                                id: idProject,
                                                offer: idOffers));
                                          },
                                          child: Container(
                                            margin: Ei.only(t: 20),
                                            height: 30,
                                            width: context.width / 3,
                                            decoration: BoxDecoration(
                                              color: LzColors.hex('006FFF'),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Textr(
                                                'Send progress project',
                                                style: Gfont.white.fsize(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkTouch(
                                          onTap: () {
                                            context.lzPush(
                                                HistoryProgress(id: idProject));
                                          },
                                          child: Container(
                                            margin: Ei.only(t: 20, l: 10),
                                            height: 30,
                                            width: context.width / 3,
                                            decoration: BoxDecoration(
                                              color: LzColors.hex('006FFF'),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Textr(
                                                'History Progress',
                                                style: Gfont.white.fsize(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkTouch(
                                            margin: Ei.only(t: 15, l: 20),
                                            onTap: () {
                                              context.lzPush(
                                                  DetailProjectExplore(
                                                      data: projectProgress));
                                            },
                                            child: Icon(
                                              Ti.infoCircle,
                                              size: 25,
                                              color: LzColors.hex('0047E3'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : const LzNoData(
                      message: 'No offers were accepted',
                    );
            },
            error: (error, _) {
              ref.read(projectProgress.notifier).getProjectProgress();
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
