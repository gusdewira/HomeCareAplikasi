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
            Column(
              children: [
                Textr(
                  margin: Ei.only(b: 10),
                  alignment: Alignment.centerLeft,
                  'Account'),
                  InkTouch(
                  onTap: () {
                    context.push(Paths.myprofile);
                  },
                  child: RowItem('My Profile', Ti.user, color1),
                ),
                RowItem('Payment Account', Ti.creditCard, color1),
                RowItem('Review Story', Ti.star, color1),

                  Textr(
                  margin: Ei.only(b: 10),
                  alignment: Alignment.centerLeft,
                  'About'),
                RowItem('Pivacy & Policy', Ti.shieldLock, color1),
                RowItem('Terms & Conditions', Ti.file, color1),

                  Textr(
                  margin: Ei.only(b: 10),
                  alignment: Alignment.centerLeft,
                  'Setting'),
                InkTouch(
                  onTap: () {
                    context.push(Paths.notificationHome);
                  },
                  child: RowItem('Notification', Ti.bell, color1),
                ),
                RowItem('Changes Password', Ti.key, color1),
                RowItem(
                  'Logout',
                  Ti.logout,
                  Colors.red,
                  onTap: () async {
                    bool? confirmed = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              'Logout',
                            ),
                          ),
                          content: Text('Are you sure you want to logout?'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            TextButton(
                              child: Text(
                                'OK',
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );

                    if (confirmed == true) {
                      bool ok = await notifier.logout();

                      if (ok) {
                        LzToast.show("Logout Successful!");
                        context.pushReplacement(Paths.login);
                      } else {
                        LzToast.show("Logout Failed!");
                      }
                    }
                  },
                ),
              ],
            ).margin(t: 10, b: 20),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    padding: Ei.all(10),
                    margin: Ei.only(r: 15),
                    decoration: BoxDecoration(
                      color: warna.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: warna,
                      size: 25,
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
          Container(
            margin: Ei.only(l: 55),
            color: Colors.grey[200],
            height: 1,
            width: double.infinity,
          ),
        ],
      ).margin(b: 10),
    );
  }
}
