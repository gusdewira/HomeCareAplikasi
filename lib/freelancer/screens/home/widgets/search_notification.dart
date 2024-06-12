import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class SearchNotification extends StatelessWidget {
  const SearchNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 130,
      right: 0,
      left: 0,
      child: Container(
        margin: Ei.only(t: 10, r: 25, l: 25),
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
                  hintText: 'Search Notification',
                  border: InputBorder.none,
                ),
              ).margin(l: 10),
            )
          ],
        ),
      ),
    );
  }
}