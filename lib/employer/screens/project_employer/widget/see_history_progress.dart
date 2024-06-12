import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class SeeHistoryProgressEmployer extends StatelessWidget {
  const SeeHistoryProgressEmployer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            LzColors.hex('11B0E6'),
            LzColors.hex('3265FF'),
          ],
          stops: const [0.0, 0.6],
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: Ei.only(t: 110),
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
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Ti.chevronLeft,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Textr(
                'Request Bid',
                style: Gfont.white.bold.fsize(18),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}