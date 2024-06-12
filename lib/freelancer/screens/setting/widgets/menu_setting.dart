import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazyui/lazyui.dart';
import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';

class ListMenuSetting extends StatelessWidget {
  const ListMenuSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Ei.only(t: 30),
      child:  Column(
        children: [
          Textr('Account', 
          style: Gfont.color(black).fsize(15),
          alignment: Alignment.centerLeft,
          ),
          Column(
            children: [
              InkTouch(
                onTap:() {context.push(Paths.myprofile);},
                child: RowItem('My Profile', Ti.user, color1)),
                InkTouch(
            onTap: () {
              context.push(Paths.paymentaccount);
            },
            child: RowItem('Payment Account', Ti.creditCard, color1)),
            RowItem('Review history', Ti.message2Cog, color1),
            ],
          ).margin(t: 10, b: 20),
          Textr('About', 
          alignment: Alignment.centerLeft,
          style: Gfont.color(black).fsize(15),),
          Column(
            children: [
              RowItem('Privacy & Policy', Ti.shieldLock, color1),
              RowItem('Tema & Conditions', Ti.file, color1),
            ],
          ).margin(t: 10, b: 20),
          Textr('Settings', 
          alignment: Alignment.centerLeft,
          style: Gfont.color(black).fsize(15),),
          Column(
            children: [
              RowItem('Notification', Ti.bell, color1),
              RowItem('Changes Password', Ti.key, color1),
              RowItem('Logout', Ti.logout, Colors.red),
            ],
          ).margin(t: 10)
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color warna;
  const RowItem(this.text, this.icon, this.warna, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        color: warna.lighten(0.10), borderRadius: Br.radius(10)),
                    child: Icon(icon, color: warna, size: 25,)),
                Text(
                  text, style: Gfont.color(LzColors.hex('000000')).fsize(15),
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
    ).margin(b: 10);
  }
}