import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class InfoRequestBid extends StatelessWidget {
  final Map bid;
  const InfoRequestBid({super.key, required this.bid});

  @override
  Widget build(BuildContext context) {
    String formatNumber(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return number.toStringAsFixed(0);
    }}
    DateTime offerDate = DateTime.parse(bid['offer_date']);
    print(bid);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
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
                              '${bid["user"]["first_name"]} ${bid["user"]["last_name"]}',
                              width: 150,
                              overflow: Tof.ellipsis,
                              style: Gfont.color(LzColors.hex('001380')),
                            ),
                            Textr(
                              bid["user"]["profession"],
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
                DateFormat('dd MMMM yyyy').format(offerDate),
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
                  formatNumber(double.parse(bid["offer_amount"])),
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
                  bid['offer_reason'],
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
                  '${bid["estimated_duration"]} months',
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
                const Spacer(),
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
