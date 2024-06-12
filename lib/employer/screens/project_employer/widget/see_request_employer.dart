import 'package:flutter/material.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/data_see_request.dart';
import 'package:lazyui/lazyui.dart';

class SeeRequestEmployer extends StatelessWidget {
  const SeeRequestEmployer({super.key});

  @override
  Widget build(BuildContext context) {
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
                Container(
                  width: context.width,
                  child: Text(
                    'EcoSolutions Waste Management Pilot',
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
                            '4000k - 6000k',
                            style: Gfont.color(LzColors.hex('001380')),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: Caa.start,
                        children: [
                          Textr(
                            maxLines: 1,
                            overflow: Tof.ellipsis,
                            'Duration',
                          ),
                          Textr(
                            maxLines: 1,
                            overflow: Tof.ellipsis,
                            '20/04/2023 - 20/05/2023',
                          ),
                        ],
                      ),
                    ),
                  ],
                ).margin(t: 10),
                Row(
                  mainAxisAlignment: Maa.start,
                  children: [
                    Icon(Ti.mapPin).margin(r: 5),
                    Textr(
                      alignment: Alignment.centerRight,
                      margin: Ei.only(r: 10),
                      'Denpasar',
                      style: Gfont.color(LzColors.hex('001380')),
                    ),
                  ],
                ).margin(t: 10),
                Textr(
                  margin: Ei.only(t: 10),
                  maxLines: 3,
                  overflow: Tof.ellipsis,
                  'The EcoSolutions Waste Management Pilot aims to implement an innovative waste management system that emphasizes ',
                ),
                Textr(
                  margin: Ei.only(t: 30),
                  maxLines: 3,
                  overflow: Tof.ellipsis,
                  'Request Bid (2)',
                  style: Gfont.bold,
                ),
                Container(
                  margin: Ei.only(t: 8),
                  height: 1,
                  width: context.width,
                  color: Colors.black,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DataSeeRequest(),
                        DataSeeRequest(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
