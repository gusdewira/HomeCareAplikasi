import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

class YourProjectEmployer extends StatelessWidget {
  final List<ProjectEmployerModel> projects;
  const YourProjectEmployer({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    String formatNumber(double number) {
    final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
  }
    return Container(
      height: 180,
      width: context.width / 1,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
            )
          ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: Caa.start,
            mainAxisAlignment: Maa.spaceBetween,
            children: [
              Text(
                'Your Projects',
                style: Gfont.color(LzColors.hex('2A1E17')).fsize(16),
              ),
              InkTouch(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: color1)),
                  child: Center(
                    child: Text(
                      'View all project',
                      style: Gfont.color(color1).fsize(12),
                    ),
                  ),
                ),
              )
            ],
          ).margin(l: 15, r: 15, t: 15, b: 15),
          Container(
            margin: Ei.only(l: 5, r: 5),
            width: context.width,
            height: 2,
            color: Colors.black12,
          ),
          Expanded(
            child: ListView.builder(
              padding: Ei.zero,
                itemCount: projects.length,
                itemBuilder: (contect, index) {
                  final project = projects[index];

                  String startDate = project.startDate.format('dd/MM/yyyy');
                  String endDate = project.endDate.format('dd/MM/yyyy');

                  String startSalary = formatNumber(project.startSalary!);
                  String endSalary = formatNumber(project.endSalary!);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              project.title!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              '$startDate - $endDate',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 15, bottom: 15),
                        child: Text(
                          'Salary $startSalary - $endSalary',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  );
                }).margin(t: 10),
          ),
        ],
      ),
    );
  }
}
