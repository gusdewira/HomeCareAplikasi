import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';
import '../content_widget/data_explore.dart';
import '../widgets/dialog_category.dart';
import '../widgets/search_widget_explore.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

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
                margin: Ei.only(t: 190),
                width: context.width,
                height: context.height,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: DataExplore(),
              ),
              Positioned(
                  top: 50,
                  left: 25,
                  child: Textr(
                    'Explore Project',
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
                           return const DialogCategory();
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
              const SearchExplore(),
            ],
          ),
        ],
      ),
    );
  }
}
