import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/info_request_bid.dart';
import 'package:lazyui/lazyui.dart';

class DataSeeRequest extends StatelessWidget {
  final Map bid;
  const DataSeeRequest({super.key, required this.bid});

  @override
  Widget build(BuildContext context) {
    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

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
              bid["user"]["profile_photo"] != null
                  ? LzImage(
                      'https://homecare.galkasoft.id/storage/${bid["user"]["profile_photo"]}',
                      radius: 50,
                      size: 50,
                    )
                  : const Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Color.fromARGB(255, 55, 70, 206),
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
                          Textr(
                              '${bid["user"]["first_name"]} ${bid["user"]["last_name"]}',
                              width: 150,
                              overflow: Tof.ellipsis,
                              style: Gfont.color(LzColors.hex('001380'))),
                          Textr(bid["user"]["profession"] ?? 'No Profession',
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
                    Text(bid['user']['address'] ?? "No Address",
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
            bid['user']['summary'] ?? 'No Summary',
            style: Gfont.color(LzColors.hex('747474')).fsize(14),
          ),
          SizedBox(
            width: context.width,
            child: Row(
              children: [
                InkTouch(
                  onTap: () async {
                    ProjectsApi projectsApi = ProjectsApi();
                    ResHandler res = await projectsApi.approveBid(bid['id']);
                    LzToast.dismiss();
                    if (!res.status) {
                      LzToast.show(res.message);
                      return false;
                    } else {
                      LzToast.show('Successfully approved bid project...');
                      Navigator.pop(context);
                      return true;
                    }
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
                      'Approve Bid',
                      style: Gfont.color(LzColors.hex('ffffff')).fsize(12),
                    ),
                  ),
                ),
                InkTouch(
                  onTap: () async {
                    ProjectsApi projectsApi = ProjectsApi();
                    ResHandler res = await projectsApi.rejectBid(bid['id']);
                    LzToast.dismiss();
                    if (!res.status) {
                      LzToast.show(res.message);
                      return false;
                    } else {
                      LzToast.show('Successfully reject bid project...');
                      Navigator.pop(context);
                      return true;
                    }
                  },
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
                const Spacer(),
                InkTouch(
                  onTap: () {
                    context.lzPush(InfoRequestBid(
                      bid: bid,
                    ));
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
