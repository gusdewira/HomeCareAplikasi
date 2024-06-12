import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';


class ClickNotification extends StatelessWidget {
  const ClickNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(onPressed: (){
           Navigator.of(context).pop();
          }, icon: const Icon(Ti.chevronLeft, size: 30,)),
        ).margin(l: 15, b: 50),
        Icon(
          Ti.alertCircleFilled,
          color: color1,
          size: 40,
        ),
        Text(
          'Proyek Information',
          style: Gfont.color(color1).bold.fsize(18),
        ).margin(t: 5),
        Text('Information for your last proyek submission.',
            style: Gfont.color(LzColors.hex('B9B9B9'))),
        Text('Please read carefully the message.',
            style: Gfont.color(LzColors.hex('B9B9B9'))),
        Container(
          margin: Ei.only(t: 130, l: 30, r: 30),
          height: 300,
          width: context.width,
          child: const Text(
            'Congratulations, the project with the name "Optimization of Supply Chain Management" has been successfully completed by the employer "PT. Galang Kangin Software"',
            textAlign: TextAlign.center,
          ),
        )
      ],
    ).margin(t: 50);
  }
}
