import 'package:flutter/material.dart';
import 'package:homecare_app/freelancer/screens/explore/content_widget/detail_project_explore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
// Pastikan Anda menambahkan ini untuk DateFormat

import '../../../../data/models/setting/project_freelancer_model.dart';
import '../../../../providers/project/project_waiting_provider.dart';
import '../../../../widgets/color_widget.dart';

class Tabbar1 extends ConsumerWidget {
  const Tabbar1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectOffers = ref.watch(projectBid);

    Future<void> refreshProjects() async {
      await ref.refresh(projectBid.notifier).getProjectBid();
    }

    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    return Column(
      children: [
        Expanded(
          child: projectOffers.when(
            data: (List<ProjectFreelancerModel> projectBids) {
              return projectBids.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: refreshProjects,
                      child: ListView.builder(
                        itemCount: projectBids.length,
                        itemBuilder: (context, index) {
                          final projectBid = projectBids[index];
                          String title = projectBid.title!;
                          String description = projectBid.description!;
                          double startSalary = projectBid.startSalary!;
                          double endSalary = projectBid.endSalary!;
                          DateTime startDate = projectBid.startDate!;
                          DateTime endDate = projectBid.endDate!;
                          String address = projectBid.user!['address'];
                          String status = projectBid.offer![0]['status'];

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
                                      ],
                                    ),
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
                                                    context.lzPush(
                                                        DetailProjectExplore(
                                                            data: projectBid));
                                                  },
                                                  child: Icon(
                                                    Ti.infoCircle,
                                                    size: 25,
                                                    color:
                                                        LzColors.hex('0047E3'),
                                                  )),
                                            ],
                                          ),
                                        ),
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
                                                    '${formatNumber(startSalary)} - ${formatNumber(endSalary)}',
                                                    style: Gfont.color(black)
                                                        .fsize(12),
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
                                                    style: Gfont.color(black)
                                                        .fsize(12),
                                                    width:
                                                        context.width / 3 + 10,
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
                                                    address,
                                                    style: Gfont.color(black)
                                                        .fsize(12),
                                                    width: context.width / 3,
                                                    maxLines: 1,
                                                    overflow: Tof.ellipsis,
                                                  ),
                                                ],
                                              ).margin(t: 5),
                                            ],
                                          ),
                                        ),
                                        Textr(
                                          description,
                                          style: Gfont.color(
                                                  LzColors.hex('747474'))
                                              .fsize(12),
                                          margin: Ei.only(t: 10),
                                          maxLines: 3,
                                          overflow: Tof.ellipsis,
                                        ),
                                       status == "ACCEPT" ?  Container(
                                          margin: Ei.only(t: 15),
                                          width: 70,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.greenAccent,
                                          ),
                                          child: Textr(
                                            'Accept',
                                            style: Gfont.white.bold.fsize(15),
                                            alignment: Alignment.center,
                                          )
                                        )  : status == "REJECT" ? Container(
                                          margin: Ei.only(t: 15),
                                          width: 70,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.redAccent,
                                          ),
                                          child: Textr(
                                            'Reject',
                                            style: Gfont.white.bold.fsize(15),
                                            alignment: Alignment.center,
                                          )
                                        ) : Container(
                                          margin: Ei.only(t: 15),
                                          width: 70,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.orangeAccent,
                                          ),
                                          child: Textr(
                                            'Waiting',
                                            style: Gfont.white.bold.fsize(15),
                                            alignment: Alignment.center,
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  : const LzNoData(message: 'You don\'t have an offer yet');
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
