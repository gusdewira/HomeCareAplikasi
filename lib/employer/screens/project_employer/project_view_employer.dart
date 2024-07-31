import 'package:flutter/material.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/tabbar1_project_employer.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/tabbar2_project_employer.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/tabbar3_project_employer.dart';
import 'package:lazyui/lazyui.dart';

class ProjectEmployerView extends StatelessWidget {
  const ProjectEmployerView({super.key});

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
                  Tab(text: 'My Project'),
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
                 Tabbar1ProjectEmployer(),
                 Tabbar2ProjectEmployer(),
                 Tabbar3ProjectEmployer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}