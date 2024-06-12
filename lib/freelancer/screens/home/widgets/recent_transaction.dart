import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazyui/lazyui.dart';

import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';

class RecentTransaction extends StatelessWidget {
  const RecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
                        child: InkWell(
                          onTap: () {
                            context.push(Paths.recentTransaction);
                          },
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
                                    // color: LzColors.hex('625AB3'),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Ti.history,
                                      size: 24,
                                      // color: LzColors.hex('0047E3'),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text('Recent Transaction',
                                        textAlign: Ta.center,
                                        style: Gfont.color(LzColors.hex('000000'))
                                            .bold
                                            .fsize(12))
                                    .margin(t: 5),
                              ],
                            ),
                          ),
                        ),
                      );
  }
}