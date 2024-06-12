import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class SearchExplore extends StatelessWidget {
  const SearchExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 100,
        left: 25,
        right: 25,
        child: Container(
          height: 40,
          width: 480,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8)),
          child: Row(
            children: [
              Iconr(
                Ti.search,
                alignment: Alignment.centerLeft,
                margin: Ei.only(l: 20),
              ),
              Expanded(
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ).margin(l: 10),
              )
            ],
          ),
        ));
  }
}
