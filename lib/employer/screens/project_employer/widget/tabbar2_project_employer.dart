import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:homecare_app/employer/providers/notification_provider.dart';
import 'package:homecare_app/employer/providers/project_active_provider.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/see_history_progress.dart';
import 'package:homecare_app/freelancer/widgets/color_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';

class Tabbar2ProjectEmployer extends ConsumerWidget {
  const Tabbar2ProjectEmployer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notification = ref.read(notificationStatusProvider.notifier);
    Future<void> refreshData() async {
      ref.refresh(projectActiveProvider);
    }

    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    void showEndContractDialog(
        BuildContext context, ProjectEmployerModel project) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: const Icon(
                  Ti.alertTriangle,
                  size: 55,
                  color: Colors.red,
                ),
                content: Text(
                  textAlign: Ta.center,
                  'If you complete this project ${project.offer![0]['id']}, the system balance will be transferred to the freelancer.',
                  style: Gfont.fs18,
                ),
                actions: [
                  Row(
                    mainAxisAlignment: Maa.center,
                    children: [
                      InkTouch(
                        onTap: () async {
                          ProjectCompletedApi projectCompletedApi =
                              ProjectCompletedApi();
                          ResHandler response = await projectCompletedApi
                              .endProject(project.offer![0]['id']);

                          if (response != null) {
                            await notification.postNotification({
                              "sent_to": project.offer?[0]["user"]["id"],
                              "title": "made",
                              "notif_text": "made",
                              "is_read": 1,
                              "offer_id": project.offer?[0]["id"]
                            });
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          width: 90,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: LzColors.hex('0047E3')),
                          child: Textr(
                            alignment: Alignment.center,
                            'End',
                            style: Gfont.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkTouch(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 90,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: Textr(
                            alignment: Alignment.center,
                            'Cancel',
                            style: Gfont.red,
                          ),
                        ),
                      )
                    ],
                  ).margin(b: 20)
                ],
              ),
              Positioned(
                  top: 290,
                  right: 55,
                  child: InkTouch(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Ti.x,
                        color: black,
                        size: 30,
                      )))
            ],
          );
        },
      );
    }

    String formatTanggal(DateTime? tanggal1, DateTime? tanggal2) {
      if (tanggal1 == null || tanggal2 == null) {
        return '';
      }

      String formattedDate1 = DateFormat('dd', 'id_ID').format(tanggal1);
      String formattedDate2 =
          DateFormat('dd MMMM yyyy', 'id_ID').format(tanggal2);

      if (tanggal1.month == tanggal2.month && tanggal1.year == tanggal2.year) {
        return '$formattedDate1 - $formattedDate2';
      } else {
        String fullFormattedDate1 =
            DateFormat('dd MMMM yyyy', 'id_ID').format(tanggal1);
        String fullFormattedDate2 =
            DateFormat('dd MMMM yyyy', 'id_ID').format(tanggal2);
        return '$fullFormattedDate1 - $fullFormattedDate2';
      }
    }

    final projectActive = ref.watch(projectActiveProvider);
    return projectActive.when(
      data: (List<ProjectEmployerModel> projects) {
        if (projects.isEmpty) {
          return RefreshIndicator(
              onRefresh: refreshData,
              child: const Center(
                child: Text(
                  'No active projects',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ));
        }
        return RefreshIndicator(
          onRefresh: refreshData,
          child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return Container(
                  padding: Ei.only(l: 20, r: 20, t: 10),
                  margin: Ei.only(l: 25, r: 25, b: 10, t: 10),
                  height: 300,
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
                      Row(
                        children: [
                          project.user?['profile_photo'] != null
                              ? LzImage(
                                  "https://homecare.galkasoft.id/storage/${project.offer?[0]['user']['profile_photo']}",
                                  radius: 50,
                                  size: 50,
                                )
                              : const Icon(
                                  Icons.account_circle,
                                  size: 50,
                                  color: Colors.blue,
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
                                      Textr(
                                          "${project.offer?[0]['user']['first_name']} ${project.offer?[0]['user']['last_name']}",
                                          width: 150,
                                          overflow: Tof.ellipsis,
                                          style: Gfont.color(
                                              LzColors.hex('001380'))),
                                      Textr(
                                          project.offer?[0]['user']
                                                  ['profession'] ??
                                              "No Profession",
                                          overflow: Tof.ellipsis,
                                          width: 150,
                                          style: Gfont.color(
                                              LzColors.hex('B9B9B9'))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                              maxLines: 1,
                              overflow: Tof.ellipsis,
                              'Hired date : ${formatTanggal(project.startDate, project.endDate)}')
                          .margin(t: 10),
                      Text(
                          'Salary: ${formatNumber(project.startSalary!)} - ${formatNumber(project.endSalary!)}'),
                      Container(
                        margin: Ei.only(t: 8, b: 8),
                        width: context.width,
                        height: 1,
                        color: Colors.grey,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: project.nameCategories!
                              .map((name) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                              .size
                                              .width),
                                      child: Text(
                                        name,
                                        style: const TextStyle(
                                          color: Color(0xFF001380),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        width: context.width,
                        height: 80,
                        child: Text(
                          project.description ?? "No Description",
                          maxLines: 4,
                          overflow: Tof.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: context.width,
                        child: Row(
                          children: [
                            InkTouch(
                              onTap: () {
                                context.lzPush(SeeHistoryProgressEmployer(
                                  id: project.id!,
                                ));
                              },
                              child: Container(
                                height: 30,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: LzColors.hex('0047E3'),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Textr(
                                  alignment: Alignment.center,
                                  'See history Progress',
                                  style: Gfont.color(LzColors.hex('ffffff'))
                                      .fsize(12),
                                ),
                              ),
                            ),
                            InkTouch(
                              onTap: () async {
                                showEndContractDialog(context, project);
                              },
                              child: Container(
                                margin: Ei.only(l: 10),
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border:
                                      Border.all(color: Colors.red, width: 2),
                                ),
                                child: Row(
                                  mainAxisAlignment: Maa.center,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Textr(
                                      alignment: Alignment.center,
                                      'End Contract',
                                      style: Gfont.red.fsize(12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkTouch(
                              onTap: () {},
                              child: Icon(
                                Ti.message,
                                size: 30,
                                color: LzColors.hex('0047E3'),
                              ),
                            )
                          ],
                        ).margin(t: 15),
                      ),
                    ],
                  ),
                );
              }),
        );
      },
      error: (error, _) {
        return LzNoData(message: 'Oops! $error');
      },
      loading: () {
        return LzLoader.bar(message: 'Loading...');
      },
    );
  }
}
