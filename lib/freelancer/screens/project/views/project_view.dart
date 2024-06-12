import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../tabbar_view/tabbar1/tabbar_content1.dart';
import '../tabbar_view/tabbar2/tabbar_content2.dart';
import '../tabbar_view/tabbar3/tabbar_content3.dart';


class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        LzColors.hex('11B0E6'), 
        LzColors.hex('3265FF'),
      ],
      stops: const [0.0, 0.6]
    ),
      ),
       child: Stack(
          children: [
            Container(
              margin: Ei.only(t: 170),
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
                left: 25,
                child: Textr('Project', style: Gfont.bold.white.fsize(25),) ),
            Container(
              margin: Ei.only(t: 100 ,l: 25, r: 25),
              height: 50,
              child: const TabBar(
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: 'Awaiting'),
                  Tab(text: 'Active'),
                  Tab(text: 'Complated'),
                ],
              ),
            ),
            const Positioned(
              top: 170,
              left: 0,
              right: 0,
              bottom: 0,
              child: TabBarView(
                children: [
                 Tabbar1(),
                 Tabbar2(),
                 Tabbar3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
