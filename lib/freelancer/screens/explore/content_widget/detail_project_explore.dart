import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/project_freelancer_model.dart';

class DetailProjectExplore extends StatelessWidget {
  final ProjectFreelancerModel data;
  const DetailProjectExplore({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    final categoryNames = data.nameCategories!;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  LzColors.hex('11B0E6'),
                  LzColors.hex('3265FF'),
                ],
                stops: const [
                  0.0,
                  0.6
                ]),
          ),
          child: Expanded(
              child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    margin: Ei.only(t: 120),
                    width: context.width,
                    height: context.height,
                    decoration: BoxDecoration(
                        color: LzColors.hex('F8F8FF'),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                  ),
                  Positioned(
                    top: 50,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Ti.chevronLeft,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 60,
                      left: 0,
                      right: 0,
                      child: Center(
                          child: Textr(
                        'Detail Project',
                        style: Gfont.white.bold.fsize(18),
                      ))),
                  Positioned(
                    left: 25,
                    right: 25,
                    top: 160,
                    child: Column(
                      mainAxisSize: Mas.min,
                      crossAxisAlignment: Caa.start,
                      children: [
                        Textr('Project Title',
                            style: Gfont.color(LzColors.hex('231E55'))
                                .fsize(15)
                                .bold),
                        Textr(
                          data.title!,
                          style: Gfont.color(LzColors.hex('595959')).fsize(13),
                          margin: Ei.only(t: 5),
                          width: context.width,
                          maxLines: 2,
                        ),
                        Textr(
                          'Project Description',
                          style: Gfont.color(LzColors.hex('231E55'))
                              .fsize(15)
                              .bold,
                          margin: Ei.only(t: 20),
                        ),
                        Textr(
                          data.description!,
                          style: Gfont.color(LzColors.hex('595959')).fsize(13),
                          margin: Ei.only(t: 5),
                          width: 350,
                        ),
                        Textr(
                          'Skills',
                          style: Gfont.color(LzColors.hex('231E55'))
                              .fsize(15)
                              .bold,
                          margin: Ei.only(t: 20),
                        ),
                        Row(
                          children: [
                            ...categoryNames
                                .map((name) => Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: LzColors.hex('94BDFF'),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        name,
                                        style:
                                            Gfont.color(LzColors.hex('000000'))
                                                .fsize(13),
                                      ),
                                    ))
                                .toList(),
                          ],
                        ).margin(t: 10),
                        Textr(
                          'Salary',
                          style: Gfont.color(LzColors.hex('231E55'))
                              .fsize(15)
                              .bold,
                          margin: Ei.only(t: 20),
                        ),
                        Textr(
                          'From ${formatNumber(data.startSalary ?? 0.0)} - ${formatNumber(data.endSalary ?? 0.0)}',
                          style: Gfont.color(LzColors.hex('595959')).fsize(13),
                          margin: Ei.only(t: 5),
                          width: 350,
                        ),
                        Textr(
                          'Attachment',
                          style: Gfont.color(LzColors.hex('231E55'))
                              .fsize(15)
                              .bold,
                          margin: Ei.only(t: 20),
                        ),
                        Container(
                          margin: Ei.only(t: 10),
                          padding: Ei.all(10),
                          height: 40,
                          width: context.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: LzColors.hex('9B9B9B'))),
                          child: Row(
                            mainAxisAlignment: Maa.spaceBetween,
                            children: [
                              Expanded(
                                child: Textr(
                                  data.attachment!.split('/')[1],
                                  style: Gfont.color(LzColors.hex('A9A6CD'))
                                      .fsize(15),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Textr(
                          'Estimated Duration',
                          style: Gfont.color(LzColors.hex('231E55'))
                              .fsize(15)
                              .bold,
                          margin: Ei.only(t: 20, b: 5),
                        ),
                        Textr(
                          '${DateFormat('dd/MM/yyyy').format(data.startDate!)} - ${DateFormat('dd/MM/yyyy').format(data.endDate!)}',
                          style: Gfont.color(LzColors.hex('A9A6CD')).fsize(13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ))),
    );
  }
}
