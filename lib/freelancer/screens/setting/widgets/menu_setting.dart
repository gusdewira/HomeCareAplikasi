import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/providers/auth_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';

class ListMenuSetting extends ConsumerWidget {
  const ListMenuSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authProvider.notifier);
    return Container(
      margin: Ei.only(t: 30),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Textr(
            //   'Account',
            //   style: Gfont.color(black).fsize(15),
            //   alignment: Alignment.centerLeft,
            // ),
            Column(
              children: [
                InkTouch(
                    onTap: () {
                      context.push(Paths.myprofile);
                    },
                    child: RowItem('My Profile', Ti.user, color1)),
                InkTouch(
                  onTap: () {
                    context.push(Paths.notificationHome);
                  },
                  child: RowItem('Notification', Ti.bell, color1)),
                RowItem('Changes Password', Ti.key, color1),
                RowItem(
                  'Logout',
                  Ti.logout,
                  Colors.red,
                  onTap: () async {
                    bool ok = await notifier.logout();

                    if (ok) {
                      LzToast.show("Logout Successful!");
                      context.pushReplacement(Paths.login);
                    } else {
                      LzToast.show("Logout Successful!");
                    }
                  },
                )
                // InkTouch(
                //     onTap: () {
                //       context.push(Paths.paymentaccount);
                //     },
                //     child: RowItem('Payment Account', Ti.creditCard, color1)),
                // RowItem('Review history', Ti.message2Cog, color1),
              ],
            ).margin(t: 10, b: 20),
            // Textr(
            //   'About',
            //   alignment: Alignment.centerLeft,
            //   style: Gfont.color(black).fsize(15),
            // ),
            // Column(
            //   children: [
            //     RowItem('Privacy & Policy', Ti.shieldLock, color1),
            //     RowItem('Tema & Conditions', Ti.file, color1),
            //   ],
            // ).margin(t: 10, b: 20),
            // Textr(
            //   'Settings',
            //   alignment: Alignment.centerLeft,
            //   style: Gfont.color(black).fsize(15),
            // ),
            // Column(
            //   children: [
            //     RowItem('Notification', Ti.bell, color1),
            //     RowItem('Changes Password', Ti.key, color1),
            //     RowItem(
            //       'Logout',
            //       Ti.logout,
            //       Colors.red,
            //       onTap: () async {
            //         bool ok = await notifier.logout();

            //         if (ok) {
            //           LzToast.show("Anda telah logout!");
            //           context.pushReplacement(Paths.login);
            //         } else {
            //           LzToast.show("Anda gagal logout!");
            //         }
            //       },
            //     )
            //   ],
            // ).margin(t: 10)
          ],
        ),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color warna;
  final VoidCallback? onTap;
  const RowItem(this.text, this.icon, this.warna, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: Maa.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      padding: Ei.all(10),
                      margin: Ei.only(r: 15),
                      decoration: BoxDecoration(
                          color: warna.lighten(0.10),
                          borderRadius: Br.radius(10)),
                      child: Icon(
                        icon,
                        color: warna,
                        size: 25,
                      )),
                  Text(
                    text,
                    style: Gfont.color(LzColors.hex('000000')).fsize(15),
                  ),
                ],
              ),
              const Icon(
                Ti.chevronRight,
                color: Colors.grey,
              ),
            ],
          ),
          Container(
            margin: Ei.only(l: 55),
            color: LzColors.hex('E6E6E8'),
            height: 1,
            width: context.width,
          ),
        ],
      ).margin(b: 10),
    );
  }
}
