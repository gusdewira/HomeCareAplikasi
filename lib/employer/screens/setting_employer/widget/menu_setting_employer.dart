import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/providers/auth_provider.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

class MenuSettingEmployer extends ConsumerWidget {
  const MenuSettingEmployer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authProvider.notifier);
    return Container(
      margin: Ei.only(t: 30),
      child: Column(
        children: [
          InkTouch(
            onTap: () {
              context.push(Paths.editProfileEmployer);
            },
            child: RowItem('Edit Profile', Ti.edit, color1)),
          RowItem('Payment Account', Ti.creditCard, color1),
          RowItem('Changes Password', Ti.key, color1),
          RowItem('Privacy & Policy', Ti.key, color1),
          // ignore: prefer_const_constructors
          RowItem('Logout', Ti.logout, Colors.red, onTap: () async {
              bool ok = await notifier.logout();

              if(ok){
                LzToast.show("Anda telah logout!");
                context.pushReplacement(Paths.login);
              }else{
                LzToast.show("Anda gagal logout!");
              }
            },)
        ],
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
