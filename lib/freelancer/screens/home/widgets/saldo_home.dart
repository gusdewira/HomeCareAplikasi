import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';

class SaldoHome extends StatelessWidget {
  const SaldoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    )));
  }
}
