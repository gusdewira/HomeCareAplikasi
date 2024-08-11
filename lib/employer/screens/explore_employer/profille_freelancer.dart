import 'package:flutter/material.dart';
import 'package:homecare_app/employer/screens/explore_employer/my_portofolios.dart';
import 'package:homecare_app/freelancer/data/models/setting/profile_freelancer_model.dart';
import 'package:lazyui/lazyui.dart';

import '../../../freelancer/widgets/color_widget.dart';
import 'widget/tabbar/tabbar1_profile_freelancerEx.dart';
import 'widget/tabbar/tabbar2_profile_freelancerEx.dart';
import 'widget/tabbar/tabbar3_profile_freelancerEx.dart';

class ProfileFreelancerEx extends StatelessWidget {
  FreelancerExplore? profile;
  ProfileFreelancerEx({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color3,
                color4,
              ],
              stops: const [
                0.0,
                0.6
              ]),
        ),
        child: Stack(
          children: [
            Container(
              margin: Ei.only(t: 380),
              width: context.width,
              height: context.height,
              decoration: BoxDecoration(
                color: color2,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            Container(
              margin: Ei.only(t: 395, l: 25, r: 25),
              height: 40,
              child: TabBar(
                indicator: BoxDecoration(
                    color: color1, borderRadius: BorderRadius.circular(20)),
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.white,
                labelStyle: Gfont.fs12,
                tabs: const [
                  Tab(
                    text: 'Experience',
                  ),
                  Tab(text: 'Qualification'),
                  Tab(text: 'Skills'),
                ],
              ),
            ),
            Positioned(
              top: 430,
              left: 0,
              right: 0,
              bottom: 0,
              child: TabBarView(
                children: [
                  Tabbar1ProfileFreelancerEx(
                    experiences: profile!.experience,
                  ),
                  Tabbar2ProfileFreelancerEx(
                    qualifications: profile!.qualifications,
                  ),
                  Tabbar3ProfileFreelancerEx(
                    skills: profile!.skills,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Ti.chevronLeft,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Center(
                    child: Textr(
                  'Profile',
                  style: Gfont.white.bold.fsize(18),
                ))),
            Column(
              children: [
                Column(
                  crossAxisAlignment: Caa.start,
                  children: [
                    Row(
                      mainAxisSize: Mas.min,
                      children: [
                        profile!.photoProfile != null &&
                                profile!.photoProfile is String
                            ? LzImage(
                                profile!.photoProfile!,
                                radius: 50,
                                size: 50,
                              )
                            : const Icon(
                                Icons.account_circle,
                                size: 50,
                                color: Colors.white,
                              ),
                        Expanded(
                          child: Column(
                            mainAxisSize: Mas.min,
                            crossAxisAlignment: Caa.start,
                            children: [
                              Textr(
                                "${profile!.firstName} ${profile!.lastName}",
                                width: 280,
                                maxLines: 1,
                                overflow: Tof.clip,
                                style: Gfont.white.fsize(20).bold,
                              ),
                              Textr(
                                profile?.profession ?? "No Profession",
                                width: 280,
                                maxLines: 1,
                                style: Gfont.color(LzColors.hex('BEC0D1'))
                                    .fsize(13),
                              )
                            ],
                          ).margin(l: 10),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: Caa.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Ti.mail,
                              color: Colors.white,
                            ).margin(r: 8),
                            Expanded(
                              child: Textr(profile?.email ?? "No Email",
                                  width: context.width,
                                  maxLines: 1,
                                  overflow: Tof.clip,
                                  style: Gfont.white.fsize(12)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Ti.phone, color: Colors.white)
                                .margin(r: 8),
                            Textr(profile?.numberPhone ?? "No Phone Number",
                                width: 130,
                                maxLines: 1,
                                overflow: Tof.clip,
                                style: Gfont.white.fsize(12))
                          ],
                        ).margin(t: 5, b: 5),
                        Row(
                          children: [
                            const Icon(Ti.mapPin, color: Colors.white)
                                .margin(r: 8),
                            Textr(profile?.address ?? "No Location",
                                width: 130,
                                maxLines: 1,
                                overflow: Tof.clip,
                                style: Gfont.white.fsize(12))
                          ],
                        ),
                      ],
                    ).margin(t: 10),
                  ],
                ),
                Container(
                  margin: Ei.only(t: 15, b: 15),
                  height: 70,
                  width: context.width,
                  child: Text(
                    profile?.summary ?? "No Summary",
                    style: Gfont.white.fsize(13),
                    maxLines: 4,
                    overflow: Tof.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    InkTouch(
                      onTap: () {
                        context.lzPush(FreelanceProfile(
                          data: profile!,
                        ));
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              color: LzColors.hex('94BDFF'),
                              borderRadius: BorderRadius.circular(20)),
                          child: Textr(
                            'Portofolios',
                            alignment: Alignment.center,
                            style: Gfont.color(
                              LzColors.hex('000000'),
                            ).fsize(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ).margin(l: 25, r: 25, t: 100),
          ],
        ),
      ),
    );
  }
}
