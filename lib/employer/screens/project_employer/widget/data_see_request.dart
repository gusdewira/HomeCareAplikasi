import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/providers/notification_provider.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/info_request_bid.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';

// ignore: must_be_immutable
class DataSeeRequest extends ConsumerWidget {
  final Map bid;
  int userId;
  DataSeeRequest({super.key, required this.bid, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    final notification = ref.read(notificationStatusProvider.notifier);
    DateTime offerDate = DateTime.parse(bid['offer_date']);
    return Container(
      padding: Ei.only(l: 20, r: 20, t: 10),
      margin: Ei.only(b: 10, t: 10),
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
                              style: Gfont.color(LzColors.hex('001380'))
                                  .fsize(11)),
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
                      maxLines: 1,
                      overflow: Tof.ellipsis,
                      width: 150,
                      style: Gfont.color(LzColors.hex('B9B9B9'))),
                ],
              ),
              Container(
                margin: Ei.only(l: 5),
                child: const Textr(
                    alignment: Alignment.center,
                    maxLines: 1,
                    overflow: Tof.ellipsis,
                    ''),
              ),
            ],
          ).margin(t: 10),
          Container(
            width: context.width,
            height: 90,
            margin: Ei.only(t: 10),
            child: Text(
              maxLines: 4,
              bid['user']['summary'] ?? 'No Summary',
              style: Gfont.color(LzColors.hex('747474')).fsize(14),
            ),
          ),
          SizedBox(
            width: context.width,
            child: bid['status'] == 'REJECT'
                ? Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: LzColors.hex('fa736b'),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Textr(
                      alignment: Alignment.center,
                      // 'Approve Bid ${bid["user"]["id"]}',
                      'Request Rejected',
                      style: Gfont.color(LzColors.hex('ffffff')).fsize(12),
                    ),
                  )
                : Row(
                    children: [
                      InkTouch(
                        onTap: () async {
                          ProjectsApi projectsApi = ProjectsApi();
                          ResHandler res =
                              await projectsApi.approveBid(bid['id']);

                          LzToast.dismiss();
                          if (res.status) {
                            LzToast.show(res.message);
                            Navigator.pop(context);

                            await notification.postNotification({
                              "sent_to": bid["user"]["id"],
                              "title": "made",
                              "notif_text": "made",
                              "is_read": 1,
                              "offer_id": bid["id"]
                            });

                            return true;
                          } else {
                            LzToast.show('Failed approved bid project...');
                            return false;
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
                            // 'Approve Bid ${bid["user"]["id"]}',
                            'Approve Bid',
                            style:
                                Gfont.color(LzColors.hex('ffffff')).fsize(12),
                          ),
                        ),
                      ),
                      InkTouch(
                        onTap: () async {
                          ProjectsApi projectsApi = ProjectsApi();
                          ResHandler res =
                              await projectsApi.rejectBid(bid['id']);
                          LzToast.dismiss();
                          if (res.status) {
                            LzToast.show(res.message);
                            Navigator.pop(context);
                            await notification.postNotification({
                              "sent_to": bid["user"]["id"],
                              "title": "made",
                              "notif_text": "made",
                              "is_read": 1,
                              "offer_id": bid["id"]
                            });
                            return true;
                          } else {
                            LzToast.show('Failed reject bid project...');
                            return false;
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
