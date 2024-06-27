import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:homecare_app/employer/providers/project_provider.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/see_request_employer.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

class Tabbar1ProjectEmployer extends ConsumerWidget {
  const Tabbar1ProjectEmployer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsEmployee = ref.watch(projectProvider);

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

    return Scaffold(
      body: projectsEmployee.when(
        data: (List<ProjectEmployerModel> projects) {
          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              final title = project.title!;
              final startSalary = formatNumber(project.startSalary!);
              final endSalary = formatNumber(project.endSalary!);
              final startDate = project.startDate!.format('yy/MM/dd');
              final endDate = project.endDate!.format('yy/MM/dd');
              final location = project.user!['location'];
              final description = project.description!;

              return Container(
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
                        title,
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
                              Textr(
                                  margin: Ei.only(r: 10),
                                  '$startSalary - $endSalary',
                                  style: Gfont.color(LzColors.hex('001380'))),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: Caa.start,
                            children: [
                              const Textr(
                                  maxLines: 1,
                                  overflow: Tof.ellipsis,
                                  'duration'),
                              Textr(
                                  alignment: Alignment.center,
                                  maxLines: 1,
                                  overflow: Tof.ellipsis,
                                  '$startDate - $endDate',
                                  style: Gfont.color(LzColors.hex('001380'))),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: Maa.end,
                                children: [
                                  const Icon(Ti.mapPin),
                                  Textr(
                                      alignment: Alignment.centerRight,
                                      margin: Ei.only(r: 10),
                                      '${location ?? "Dendapasar"}',
                                      style:
                                          Gfont.color(LzColors.hex('001380'))),
                                ],
                              ),
                              const Textr(
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
                        description),
                    InkTouch(
                      onTap: () {
                        context.lzPush(SeeRequestEmployer(project: project,));
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
                                style: Gfont.color(LzColors.hex('ffffff'))
                                    .fsize(12),
                              ),
                            ),
                          ],
                        ).margin(t: 20),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        error: (error, _) {
          return LzNoData(message: 'Oops! $error');
        },
        loading: () => LzLoader.bar(message: 'Loading...'),
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
