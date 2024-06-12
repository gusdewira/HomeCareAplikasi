import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';

class BuildColoredGrid extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final String text;

  const BuildColoredGrid(BuildContext context, {super.key, 
    required this.iconData,
    required this.text,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
     return SizedBox(
       width: context.width / 4,
       height: 110,
       child: Column(
         mainAxisSize: Mas.min,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Container(
             width: 60,
             height: 60,
             decoration: BoxDecoration(
               color: color.lighten(0.12),
               borderRadius: BorderRadius.circular(10),
             ),
             child: Center(
               child: Icon(
                 iconData,
                 color: color1,
                 size: 27,
               ),
             ),
           ),
           const SizedBox(height: 12),
           Textr(
             text,
             textAlign: Ta.center,
             style:  Gfont.bold.fsize(12)
           )
         ],
       ),
     );
  }
}