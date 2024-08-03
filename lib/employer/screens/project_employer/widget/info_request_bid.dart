import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:lazyui/lazyui.dart';

class InfoRequestBid extends StatelessWidget {
  final Map bid;
  const InfoRequestBid({super.key, required this.bid});

  @override
  Widget build(BuildContext context) {
    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    DateTime offerDate = DateTime.parse(bid['offer_date']);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
                bid["user"]["profile_photo"] != null
                    ? LzImage(
                        'https://homecare.galkasoft.id/storage/${bid["user"]["profile_photo"]}',
                        radius: 50,
                        size: 50,
                      )
                    : const Icon(
                        Icons.account_circle,
                        size: 50,
                        color: Colors.white,
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
                              bid["user"]["profession"] ?? "No Profession",
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
                Container(
                  height: 280,
                  child: Text(
                    '${bid["estimated_duration"]} months',
                    style: Gfont.color(LzColors.hex('595959')),
                  ),
                )
              ],
            ).margin(t: 10, b: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                const Spacer(),
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
                ),
              ],
            ).margin(b: 20),
          ],
        ),
      ),
    );
  }
}
