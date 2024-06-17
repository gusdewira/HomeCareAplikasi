import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../../data/models/setting/profile_freelancer_model.dart';
import '../../../providers/setting/profile_provider.dart';
import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';
import '../tabbar/tabbar1_profile_home.dart';
import '../tabbar/tabbar2_profile_home.dart';
import '../tabbar/tabbar3_profile_home.dart';

class ProfileHome extends StatelessWidget {
  const ProfileHome({super.key});

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
        child: Consumer(
          builder: (context, ref, _) {
            final profileData = ref.watch(profileFreelancerProvider);
            return profileData.when(
              data: (ProfileFreelancerModel profileFreelancer) {
                if (profileFreelancer.id == null) {
                  return const LzNoData(
                      message:
                          'There is no data yet, please add data in the add profileFreelancer menu');
                }
                String firstName = profileFreelancer.firstName ?? '';
                String lastName = profileFreelancer.lastName ?? '';
                String email = profileFreelancer.email ?? '';
                String numberPhone = profileFreelancer.numberPhone ?? '';
                String summary = profileFreelancer.summary ?? '';
                String profession = profileFreelancer.profession ?? '';
                String address = profileFreelancer.address ?? '';

                return Stack(
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
                            color: color1,
                            borderRadius: BorderRadius.circular(20)),
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.white,
                        labelStyle: Gfont.fs12,
                        tabs: const [
                          Tab(text: 'Experience',),
                          Tab(text: 'Qualification'),
                          Tab(text: 'Skills'),
                        ],
                      ),
                    ),
                    const Positioned(
                      top: 430,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: TabBarView(
                        children: [
                          Tabbar1ProfileHome(),
                          Tabbar2ProfileHome(),
                          Tabbar3Profilehome(),
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
                          'My Profile',
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
                                const LzImage(
                                  'profile.jpg',
                                  size: 50,
                                  radius: 50,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: Mas.min,
                                    crossAxisAlignment: Caa.start,
                                    children: [
                                      Textr(
                                        '$firstName $lastName',
                                        width: 280,
                                        maxLines: 1,
                                        overflow: Tof.clip,
                                        style: Gfont.white.fsize(20).bold,
                                      ),
                                      Textr(
                                        profession,
                                        width: 280,
                                        maxLines: 1,
                                        style:
                                            Gfont.color(LzColors.hex('BEC0D1'))
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
                                    Icon(Ti.mail, color: Colors.white,).margin(r: 8),
                                    Expanded(
                                      child: Textr(email,
                                          width: context.width,
                                          maxLines: 1,
                                          overflow: Tof.clip,
                                          style: Gfont.white.fsize(12)),
                                    )
                                  ],
                                ),
                                 Row(
                                  children: [
                                    Icon(Ti.phone, color: Colors.white).margin(r: 8),
                                    Textr(numberPhone,
                                        width: 130,
                                        maxLines: 1,
                                        overflow: Tof.clip,
                                        style: Gfont.white.fsize(12))
                                  ],
                                ).margin(t: 5, b: 5),
                                Row(
                                  children: [
                                    Icon(Ti.mapPin, color: Colors.white).margin(r: 8),
                                    Textr(address,
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
                            summary,
                            style: Gfont.white.fsize(13),
                            maxLines: 4,
                            overflow: Tof.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            InkTouch(
                              onTap: () {
                                context.push(Paths.myPortofolios);
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
                                    'My Portofolios',
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
                );
              },
              error: (error, _) {
                return LzNoData(message: 'Oops! $error');
              },
              loading: () {
                return LzLoader.bar(message: 'Loading...');
              },
            );
          },
        ),
      ),
    );
  }
}
