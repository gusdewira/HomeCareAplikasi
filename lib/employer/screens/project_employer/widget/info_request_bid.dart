import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class InfoRequestBid extends StatelessWidget {
  const InfoRequestBid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Textr(
          'Detail Bid',
          style: Gfont.black.bold.fsize(18),
        ),
        centerTitle: true, // Center the title horizontally
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const LzImage(
                  'profile.jpg',
                  radius: 40,
                  size: 50,
                ),
                Expanded(
                  child: Container(
                    margin: Ei.only(l: 10),
                    width: context.width,
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Textr(
                              'Ayu Istri',
                              width: 150,
                              overflow: Tof.ellipsis,
                              style: Gfont.color(LzColors.hex('001380')),
                            ),
                            Textr(
                              'Web Development',
                              overflow: Tof.ellipsis,
                              width: 150,
                              style: Gfont.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: Ei.only(l: 60), // 50 (image size) + 10 (margin)
              child: Text(
                '20 April 2024',
                style: Gfont.black.bold.fsize(12),
              ),
            ),
            Container(
              margin: Ei.only(t: 10),
              height: 1,
              width: context.width,
              color: Colors.grey,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bid Amount',
                  overflow: Tof.ellipsis,
                  style: Gfont.color(LzColors.hex('001380')),
                ),
                Text(
                  '500k',
                  style: Gfont.color(LzColors.hex('595959')),
                )
              ],
            ).margin(t: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reason',
                  overflow: Tof.ellipsis,
                  style: Gfont.color(LzColors.hex('001380')),
                ),
                Text(
                  'The redesign is crucial to maintaining a modern and user-friendly online presence. It will improve brand perception, attract new users, and better serve our existing audience. This project aligns with our strategic goals of staying ahead in the digital landscape. ',
                  style: Gfont.color(LzColors.hex('595959')),
                )
              ],
            ).margin(t: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimated Duration',
                  overflow: Tof.ellipsis,
                  style: Gfont.color(LzColors.hex('001380')),
                ),
                Text(
                  '2 months',
                  style: Gfont.color(LzColors.hex('595959')),
                )
              ],
            ).margin(t: 10, b: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 100,
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: LzColors.hex('0047E3'),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Textr(
                    alignment: Alignment.center,
                    'Approve Bid',
                    style: Gfont.color(LzColors.hex('ffffff')).fsize(12),
                  ),
                ),
                Spacer(),
                Container(
                  height: 30,
                  width: 100,
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Textr(
                    alignment: Alignment.center,
                    'Reject Bid',
                    style: Gfont.red.fsize(12),
                  ),
                ),
              ],
            ).margin(b: 20),
          ],
        ),
      ),
    );
  }
}
