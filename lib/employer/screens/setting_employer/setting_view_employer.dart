import 'package:flutter/material.dart';
import 'package:homecare_app/employer/screens/setting_employer/widget/menu_setting_employer.dart';
import 'package:lazyui/lazyui.dart';

import '../../../freelancer/widgets/color_widget.dart';

class SettingEmployerView extends StatelessWidget {
  const SettingEmployerView({super.key});

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
      child: Stack(
                children: [
                  Container(
                    margin: Ei.only(t: 120),
                    width: context.width,
                    height: context.height,
                    decoration: BoxDecoration(
                        color: color2,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                  ),
                  Positioned(
                      top: 50,
                      left: 25,
                      child: Textr(
                        'Setting',
                        style: Gfont.bold.white.fsize(25),
                      )),
                  Positioned(
                      top: 85,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.white, width: 4)),
                            child:
                                 const LzImage('profile.jpg', size: 80, radius: 40),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Ayu Istri',
                            style: Gfont.color(black).bold,
                          ),
                          Container(
                              margin: Ei.only(t: 5),
                              padding: Ei.only(l: 10, r: 10, b: 5, t: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: LzColors.hex('94BDFF').lighten(0.25)),
                              child: Text(
                                'ayuistri@gmail.com',
                                style:
                                    Gfont.color(LzColors.hex('000000')).fsize(12),
                              )),
                          Container(
                              margin: Ei.only(l: 25, r: 25),
                              child: const MenuSettingEmployer())
                        ],
                      )),
                ],
              ),
    );
  }
}