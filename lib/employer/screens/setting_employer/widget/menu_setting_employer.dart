import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/data/models/profile_model.dart';
import 'package:homecare_app/employer/providers/auth_provider.dart';
import 'package:homecare_app/employer/screens/setting_employer/widget/edit_profile_employer.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

// ignore: must_be_immutable
class MenuSettingEmployer extends ConsumerWidget {
  ProfileEmployerModel profile;
  MenuSettingEmployer({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authProvider.notifier);
    return Container(
      margin: Ei.only(t: 30),
      child: Column(
        children: [
          InkTouch(
            onTap: () {
              context.lzPush(EditProfileEmployer(
                data: profile,
              ));
            },
            child: RowItem('Edit Profile', Ti.edit, color1),
          ),
          InkTouch(
            onTap: () {
              context.push(Paths.notificationHome);
            },
            child: RowItem('Notification', Ti.bell, color1),
          ),
          RowItem('Payment Account', Ti.creditCard, color1),
          RowItem('Changes Password', Ti.key, color1),
          RowItem('Privacy & Policy', Ti.shieldLock, color1),
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
          )
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
                      borderRadius: Br.radius(10),
                    ),
                    child: Icon(
                      icon,
                      color: warna,
                      size: 25,
                    ),
                  ),
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
