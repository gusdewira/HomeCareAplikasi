import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../providers/setting/edit_profile_provider.dart';

class MyPortofolios extends ConsumerWidget {
  const MyPortofolios({super.key});

  

  @override
  Widget build(BuildContext context,WidgetRef ref) {
     final notifier = ref.read(editProfilChangeNotifier.notifier);
    return Stack(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Ti.chevronLeft,
                  size: 30,
                )).margin(l: 15, t: 60),
                Expanded(child: Text('My Portofolio', style: Gfont.fs18.bold,).margin(t: 60, l: 5))
          ],
        ),
         notifier.watch((state) => Column(
  children: [
    Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 120),
      height: context.height/2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: LzColors.hex('006FFF')),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          ref.read(editProfilChangeNotifier.notifier).image,
          fit: BoxFit.cover, // You can adjust the fit as needed
        ),
      ),
    ),
  ],
),
),

  ]);
  }
}
