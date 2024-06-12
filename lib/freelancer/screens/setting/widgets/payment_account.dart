import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';
import '../../../widgets/form_widget.dart';

class PaymentAccount extends StatelessWidget {
  const PaymentAccount({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: ListView(
        padding: Ei.zero,
        children: [
          Stack(
            children: [
              Container(
                margin: Ei.only(t: 190),
                width: context.width,
                height: context.height,
                decoration: BoxDecoration(
                    color: LzColors.hex('F8F8FF'),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
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
                    'Payment Account',
                    style: Gfont.white.bold.fsize(18),
                  ))),
              Positioned(
                  top: 110,
                  left: 50,
                  right: 50,
                  child: Container(
                    height: 180,
                    width: 300,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              LzColors.hex('7477BE'),
                              LzColors.hex('34B3EA').lighten(0.7),
                            ],
                            stops: const [
                              0.0,
                              0.6
                            ]),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: Caa.start,
                      children: [
                        Text(
                          'Wallet Card',
                          style: Gfont.white.fsize(18),
                        ).margin(b: 15),
                        Text(
                          '1124 4444 **** ****',
                          style: Gfont.white.bold.fsize(25),
                        ).margin(b: 15),
                        Textr('Wayan Sumerta',
                        width: 190,
                        maxLines: 1,
                        overflow: Tof.clip, 
                        style: Gfont.white.bold.fsize(18))
                      ],
                    ).margin(t: 30, l: 30),
                  )),
              Positioned(
                  top: 220,
                  right: 70,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50)),
                  )),
              Positioned(
                  top: 220,
                  right: 92,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50)),
                  )),
             
              Column(
                children: [
                  FormWidget('Card Holder Name', 'Card Holder Name', 80,context.width,color1),
                  FormWidget('Card Number', 'Card Number', 80,context.width,color1),
                  FormWidget3('Card Expired Date', 'Card Expired Date',Ti.calendar, color1, 30, 80, context.width),
                  FormWidget3('Bank Name', 'Card Number', Ti.chevronDown,color1, 30, 80, context.width)
                ],
              ).margin(t: 320, l: 25, r: 25),
            ],
          ),
        ],
      ),
    ),
    bottomNavigationBar: LzButton(
        radius: 20,
        color: color1,
        textColor: Colors.white,
        text: 'Save',
      ).theme1(). margin(b: 50),
    );
  }
}
