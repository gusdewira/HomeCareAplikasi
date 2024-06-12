import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazyui/lazyui.dart';

import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';
import '../widgets/search_recent_transaction.dart';


class RecentTransactionView extends StatelessWidget {
  const RecentTransactionView({super.key});

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
      stops: const [0.0, 0.6]
    ),
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
                      'Recent Transaction',
                      style: Gfont.white.bold.fsize(18),
                    ))),
          const SearchRecentTransaction(),

          Positioned(
            top: 210,
            right: 25,
            left: 25,
            child: Column(
              crossAxisAlignment: Caa.start,
              children: [
                Text('October, 2023', style: Gfont.color(LzColors.hex('747474')).fsize(13),),
                InkTouch(
                  onTap: () {
                    context.push(Paths.invoiceRecentTransaction);
                  },
                  child: Row(
                    children: [
                      const LzImage('profile1.jpg', size: 50, radius: 25,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: Caa.start,
                          children: [
                            Row(
                              mainAxisAlignment: Maa.spaceBetween,
                              children: [
                                Text('Deangga', style: Gfont.color(LzColors.hex('000000')).fsize(13),),
                                Textr('200k', 
                                style: Gfont.color(LzColors.hex('079D53')).fsize(13),
                                alignment: Alignment.center,
                                radius: BorderRadiusDirectional.circular(10),
                                color: LzColors.hex('079D53').lighten(0.3),
                                width: 45,
                                )
                              ],
                            ),
                            Text('20/04/2023 | 10.00 AM | Debit', style: Gfont.color(LzColors.hex('747474')).fsize(13),)
                          ],
                        ).margin(l: 10),
                      )
                    ],
                  ).margin(t: 10),
                ),


                InkTouch(
                  onTap: () {
                    context.push(Paths.invoiceRecentTransaction);
                  },
                  child: Row(
                    children: [
                      const LzImage('profile2.jpg', size: 50, radius: 25,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: Caa.start,
                          children: [
                            Row(
                              mainAxisAlignment: Maa.spaceBetween,
                              children: [
                                Text('Gandhi', style: Gfont.color(LzColors.hex('000000')).fsize(13),),
                                Textr('200k', 
                                style: Gfont.color(LzColors.hex('079D53')).fsize(13),
                                alignment: Alignment.center,
                                radius: BorderRadiusDirectional.circular(10),
                                color: LzColors.hex('079D53').lighten(0.3),
                                width: 45,
                                )
                              ],
                            ),
                            Text('20/04/2023 | 10.00 AM | Debit', style: Gfont.color(LzColors.hex('747474')).fsize(13),)
                          ],
                        ).margin(l: 10),
                      )
                    ],
                  ).margin(t: 10),
                ),


                
                InkTouch(
                  onTap: () {
                    context.push(Paths.invoiceRecentTransaction);
                  },
                  child: Row(
                    children: [
                      const LzImage('profile3.jpg', size: 50, radius: 25,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: Caa.start,
                          children: [
                            Row(
                              mainAxisAlignment: Maa.spaceBetween,
                              children: [
                                Text('Istriwhy', style: Gfont.color(LzColors.hex('000000')).fsize(13),),
                                Textr('200k', 
                                style: Gfont.color(LzColors.hex('079D53')).fsize(13),
                                alignment: Alignment.center,
                                radius: BorderRadiusDirectional.circular(10),
                                color: LzColors.hex('079D53').lighten(0.3),
                                width: 45,
                                )
                              ],
                            ),
                            Text('20/04/2023 | 10.00 AM | Debit', style: Gfont.color(LzColors.hex('747474')).fsize(13),)
                          ],
                        ).margin(l: 10),
                      )
                    ],
                  ).margin(t: 10),
                ),
              ],
            ))
        ],
      ),
    );
  }
}