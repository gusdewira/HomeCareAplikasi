import 'package:flutter/material.dart';
import 'package:homecare_app/employer/screens/explore_employer/widget/category.dart';
import 'package:homecare_app/employer/screens/explore_employer/widget/data.dart';
import 'package:homecare_app/employer/screens/explore_employer/widget/search_freelancer.dart';
import 'package:lazyui/lazyui.dart';

import '../../../freelancer/widgets/color_widget.dart';

class ExploreEmployerView extends StatelessWidget {
  const ExploreEmployerView({super.key});

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
      child: LzListView(
        padding: Ei.zero,
        children: [
          Stack(
            children: [
              Container(
                margin: Ei.only(t: 180),
                width: context.width,
               height: context.height,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: const Column(
                  children: [
                    DataExploreFreelancer(),
                  ],
                ),
              ),
              Positioned(
                  top: 50,
                  left: 25,
                  child: Textr(
                    'Explore Freelancer',
                    style: Gfont.bold.white.fsize(25),
                  )),
              Positioned(
                top: 140,
                left: 15,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                           return const CategoryFreelancer();
                          },
                        );
                      },
                      icon: const Icon(
                        Ti.sortDescending,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 155,
                left: 55,
                child: Textr(
                  'Filter',
                  style: Gfont.white.fsize(15),
                ),
              ),
              const SearchFreelancer(),
            ],
          ),
        ],
      ),
    );
  }
}