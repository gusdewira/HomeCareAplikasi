import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/data_see_request.dart';
import 'package:lazyui/lazyui.dart';

class SeeRequestEmployer extends StatelessWidget {
  final ProjectEmployerModel project;
  const SeeRequestEmployer({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    int countOffers = project.offer!.where((offer) => offer['status'] == 'WAITING').length;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            LzColors.hex('11B0E6'),
            LzColors.hex('3265FF'),
          ],
          stops: const [0.0, 0.6],
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: Ei.only(t: 110),
            width: context.width,
            height: context.height,
            decoration: BoxDecoration(
              color: LzColors.hex('F8F8FF'),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
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
                'Request Bid',
                style: Gfont.white.bold.fsize(18),
              ),
            ),
          ),
          Container(
            padding: Ei.only(t: 10),
            margin: Ei.only(l: 25, r: 25, b: 20, t: 120),
            height: context.height,
            width: context.width,
            child: Column(
              mainAxisSize: Mas.min,
              crossAxisAlignment: Caa.start,
              children: [
                SizedBox(
                  width: context.width,
                  child: Text(
                    project.title!,
                    maxLines: 1,
                    overflow: Tof.ellipsis,
                    style: Gfont.color(LzColors.hex('001380')).fsize(18),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: Caa.start,
                        children: [
                          Textr(
                            margin: Ei.only(r: 10),
                            'Salary',
                            style: Gfont.color(LzColors.hex('001380')),
                          ),
                          Textr(
                            margin: Ei.only(r: 10),
                            '${formatNumber(project.startSalary!)} - ${formatNumber(project.endSalary!)}',
                            style: Gfont.color(LzColors.hex('001380')),
                          ),
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
                            'Duration',
                          ),
                          Textr(
                            maxLines: 1,
                            overflow: Tof.ellipsis,
                            "${project.startDate!.format('yy/MM/dd')} - ${project.endDate!.format('yy/MM/dd')}",
                          ),
                        ],
                      ),
                    ),
                  ],
                ).margin(t: 10),
                Textr(
                  margin: Ei.only(t: 10),
                  maxLines: 3,
                  overflow: Tof.ellipsis,
                  project.description!,
                ),
                Textr(
                  margin: Ei.only(t: 30),
                  maxLines: 3,
                  overflow: Tof.ellipsis,
                  'Request Bid ($countOffers)',
                  style: Gfont.bold,
                ),
                Container(
                  margin: Ei.only(t: 8),
                  height: 1,
                  width: context.width,
                  color: Colors.black,
                ),
               countOffers <= 0 ? const Text("Request bid is empty!").margin(t: 10) : Expanded(
                    child: ListView.builder(
                        itemCount: project.offer!.length,
                        itemBuilder: (context, index) {
                          if(project.offer![index]['status'] == "WAITING") {
                            return DataSeeRequest(
                              bid: project.offer![index],
                              userId: project.user!['id']);
                          }
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
