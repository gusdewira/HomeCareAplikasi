import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';

class BalanceWithDrawl extends StatelessWidget {
  const BalanceWithDrawl({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: Ei.only(l: 5),
          width: context.width / 2,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: color1.lighten(0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Ti.clockDollar,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Text('Balance Withdrawal',
                      textAlign: Ta.center,
                      style: Gfont.color(LzColors.hex('000000')).bold.fsize(12))
                  .margin(t: 5),
            ],
          ),
        ),
      ),
    );
  }
}
