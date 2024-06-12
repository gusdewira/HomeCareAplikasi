import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/screens/home_employer/widget/allproject_employer.dart';
import 'package:homecare_app/employer/screens/home_employer/widget/belancewithdraw_employer.dart';
import 'package:homecare_app/employer/screens/home_employer/widget/recenttransaction_employee.dart';
import 'package:homecare_app/employer/screens/home_employer/widget/topup_employer.dart';
import 'package:homecare_app/employer/screens/home_employer/widget/yourproject_employer.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:lazyui/lazyui.dart';

import '../../../freelancer/widgets/color_widget.dart';

class HomeEmployerView extends StatelessWidget {
  const HomeEmployerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              color3,
              color4,
            ],
            stops: const [
              0.0,
              0.6
            ]),
      ),
      child: LzListView(
        padding: Ei.zero,
        children: [
          Stack(
            children: [
              Positioned(
                top: 70,
                left: 25,
                child: Row(
                  children: [
                    const LzImage(
                      'profile.jpg',
                      radius: 50,
                      size: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textr(
                          'Ayu Istri',
                          width: 200,
                          maxLines: 1,
                          overflow: Tof.clip,
                          style: Gfont.bold.white,
                        ),
                        Textr(
                          'ayuistri@gmail.com',
                          width: 200,
                          maxLines: 1,
                          overflow: Tof.clip,
                          style: Gfont.white.fsize(12),
                        )
                      ],
                    ).margin(l: 15),
                  ],
                ),
              ),
              Positioned(
                  top: 50,
                  right: 25,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Ti.bell,
                        size: 30,
                        color: Colors.white,
                      ))),
              Container(
                margin: Ei.only(t: 160),
                width: context.width,
                height: context.height,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BelanceWithDrawEmployer(),
                      SizedBox(width: 10),
                      TopUpEmployer(),
                      SizedBox(width: 10),
                      RecentTransactionEmployer(),
                    ],
                  ),
                  InkTouch(
                    onTap: () {
                      context.push(Paths.postingProjectEmployer);
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: color1.lighten(0.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(
                              Ti.plus,
                              size: 24,
                              color: Colors.white,
                            ),
                            Text('Posting Project', style: Gfont.white,)
                          ],
                        ).margin(t: 10, b: 10),
                      ),
                    ),
                  ),
                  const YourProjectEmployer().margin(t: 20, b: 20),
                  const AllProjectEmployer()
                ],
              ).margin(l: 25, r: 25, t: 220),
              Positioned(
                  top: 120,
                  left: 25,
                  right: 25,
                  child: Container(
                      padding: Ei.only(l: 20, r: 20),
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: color1, width: 1),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: Maa.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: Mas.min,
                            crossAxisAlignment: Caa.start,
                            children: [
                              Text(
                                'Saldo Anda',
                                style: Gfont.bold.fsize(15),
                              ),
                              Text(
                                'Rp. 500.000,00',
                                style: Gfont.bold.fsize(20),
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Ti.chevronRight,
                                size: 30,
                              ))
                        ],
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
