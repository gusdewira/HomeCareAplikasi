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
    Future<void> refreshData() async {
      ref.refresh(projectProvider);
    }

    final projectsEmployee = ref.watch(projectProvider);

    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    return Scaffold(
      body: projectsEmployee.when(
        data: (List<ProjectEmployerModel> projects) {
          if (projects.isEmpty) {
            return RefreshIndicator(
                onRefresh: refreshData,
                child: const Center(
                  child: Text('Project is empty'),
                ));
          }
          return RefreshIndicator(
            onRefresh: refreshData,
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                final title = project.title!;
                final startSalary = formatNumber(project.startSalary!);
                final endSalary = formatNumber(project.endSalary!);
                final startDate = project.startDate!.format('yy/MM/dd');
                final endDate = project.endDate!.format('yy/MM/dd');
                final description = project.description!;
                final status = project.offer!.isNotEmpty
                    ? project.offer![0]['status']
                    : "null";

                return Container(
                  padding: Ei.only(l: 20, r: 20, t: 10),
                  margin: Ei.only(l: 25, r: 25, b: 10, t: 10),
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
                        child: Text(
                          maxLines: 1,
                          overflow: Tof.ellipsis,
                          title,
                          style: Gfont.color(LzColors.hex('001380')).fsize(18),
                        ),
                      ),
                      SizedBox(
                        width: context.width,
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: Caa.start,
                                children: [
                                  Textr(margin: Ei.only(r: 10), 'Salary'),
                                  Textr(
                                      maxLines: 2,
                                      overflow: Tof.ellipsis,
                                      margin: Ei.only(r: 10),
                                      '$startSalary - $endSalary',
                                      style: Gfont.color(LzColors.hex('001380'))
                                          .fsize(12)),
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
                                      maxLines: 1,
                                      overflow: Tof.ellipsis,
                                      '$startDate - $endDate',
                                      style: Gfont.color(LzColors.hex('001380'))
                                          .fsize(12)),
                                ],
                              ),
                            ),
                          ],
                        ).margin(t: 10),
                      ),
                      Container(
                        width: context.width,
                        height: 40,
                        margin: Ei.only(t: 10),
                        child: Text(
                            maxLines: 3, overflow: Tof.ellipsis, description),
                      ),
                      (status != "ACCEPT" && status != "END")
                          ? InkTouch(
                              onTap: () {
                                context.lzPush(SeeRequestEmployer(
                                  project: project,
                                ));
                              },
                              child: SizedBox(
                                width: context.width,
                                child: Row(
                                  mainAxisAlignment: Maa.end,
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
                                        style:
                                            Gfont.color(LzColors.hex('ffffff'))
                                                .fsize(12),
                                      ),
                                    ),
                                  ],
                                ).margin(t: 20),
                              ),
                            )
                          : SizedBox(
                              width: context.width,
                              child: Row(
                                mainAxisAlignment: Maa.end,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: status == "ACCEPT"
                                          ? LzColors.hex('4c83fc')
                                          : LzColors.hex('23e82d'),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Textr(
                                      alignment: Alignment.center,
                                      status,
                                      style: Gfont.color(LzColors.hex('ffffff'))
                                          .fsize(12),
                                    ),
                                  ),
                                ],
                              ).margin(t: 20),
                            )
                    ],
                  ),
                );
              },
            ),
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
