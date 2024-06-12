import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class SearchSupport extends StatelessWidget {
  const SearchSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: context.width/1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: LzColors.hex('E6E6E8')),
      child: Row(
        children: [
          Iconr(
            Ti.search,
            color: LzColors.hex('747474'),
            alignment: Alignment.centerLeft,
            margin: Ei.only(l: 20),
          ),
          Expanded(
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search Project',
                border: InputBorder.none,
              ),
            ).margin(l: 10),
          )
        ],
      ),
    );
  }
}