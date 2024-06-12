import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Poslign(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: Ei.only(t: context.viewPadding.top,b: 0, r: 0, l: 20),
        child:  Row(
          children: [const Text('Dasboard'),
          
          Row(
            children: [
             InkTouch(
              onTap: (){},
              padding: Ei.all(20), child: const Icon(Ti.bell),
             )
            ],
          )
          ],
        ),
      ),
    );
  }
}
