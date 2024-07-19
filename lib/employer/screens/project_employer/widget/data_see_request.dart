import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/info_request_bid.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:lazyui/lazyui.dart';

class DataSeeRequest extends StatelessWidget {
  final Map bid;
  const DataSeeRequest({super.key, required this.bid});

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
    return Container(
      padding: Ei.only(l: 20, r: 20, t: 10),
      margin: Ei.only(b: 20, t: 20),
      width: context.width / 1,
      height: 280,
      decoration: BoxDecoration(
          color: LzColors.hex('FFFFFF'),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
            )
          ]),
      child: Column(
        mainAxisSize: Mas.min,
        crossAxisAlignment: Caa.start,
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
                  height: 50,
                  child: Row(
                    crossAxisAlignment: Caa.start,
                    mainAxisAlignment: Maa.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Textr('${bid["user"]["first_name"]} ${bid["user"]["last_name"]}',
                              width: 150,
                              overflow: Tof.ellipsis,
                              style: Gfont.color(LzColors.hex('001380'))),
                          Textr(bid["user"]["profession"] ?? '',
                              overflow: Tof.ellipsis,
                              width: 150,
                              style: Gfont.color(LzColors.hex('B9B9B9'))),
                        ],
                      ),
                      Column(
                        children: [
                          Textr(offerDate.format('yy/MM/dd'),
                              overflow: Tof.ellipsis,
                              width: 100,
                              style: Gfont.color(LzColors.hex('001380'))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Textr('Bid Amount',
                      width: 150,
                      overflow: Tof.ellipsis,
                      style: Gfont.color(LzColors.hex('001380'))),
                  Textr(formatNumber(double.parse(bid["offer_amount"])),
                      overflow: Tof.ellipsis,
                      width: 150,
                      style: Gfont.color(LzColors.hex('B9B9B9'))),
                ],
              ),
              Container(
                margin: Ei.only(l: 5),
                width: 100,
                child: Row(
                  children: [
                    Icon(
                      Ti.mapPin,
                      color: LzColors.hex('001380'),
                      size: 15,
                    ),
                    Text(bid['user']['address'],
                        overflow: Tof.ellipsis,
                        style: Gfont.color(LzColors.hex('001380'))),
                  ],
                ),
              ),
            ],
          ).margin(t: 10),
          Textr(
            margin: Ei.only(t: 10),
            maxLines: 4,
            bid['user']['summary'] ?? '',
            style: Gfont.color(LzColors.hex('747474')).fsize(14),
          ),
          SizedBox(
            width: context.width,
            child: Row(
              children: [
                InkTouch(
                  onTap:() {
                    context.push(Paths.infoRequestBid);
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: LzColors.hex('0047E3'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Textr(
                      alignment: Alignment.center,
                      'Aprove Bid',
                      style: Gfont.color(LzColors.hex('ffffff')).fsize(12),
                    ),
                  ),
                ),
                InkTouch(
                  onTap: () {},
                  child: Container(
                    margin: Ei.only(l: 10),
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: Maa.center,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Textr(
                          alignment: Alignment.center,
                          'Reject Bid',
                          style: Gfont.red.fsize(12),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkTouch(
                  onTap: () {
                    context.lzPush(InfoRequestBid(bid: bid,));
                  },
                  child: Icon(
                    Ti.infoCircle,
                    size: 30,
                    color: LzColors.hex('0047E3'),
                  ),
                )
              ],
            ).margin(t: 15),
          ),
        ],
      ),
    );
  }
}
