import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/profile_freelancer_model.dart';
import '../../../providers/setting/profile_provider.dart';
import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';
import '../widgets/all_project_home.dart';
import '../widgets/balance_withdrawl.dart';
import '../widgets/recent_transaction.dart';
import '../widgets/saldo_home.dart';
import '../widgets/your_project_home.dart';


class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileFreelancerProvider);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [color3, color4],
            stops: const [0.1, 0.7]),
      ),
      child: profileData.when(
        data: (ProfileFreelancerModel profile) {
          if (profile.id == null) {
            return const LzNoData(
                message: 'There is no data yet, please add data in the add experience menu');
          }
          String email = profile.email ?? '';
          String fistName = profile.firstName ?? '';
          String lastName = profile.lastName ?? '';

          return Stack(
            children: [
              Positioned(
                top: 60,
                left: 25,
                child: InkTouch(
                  onTap: () {
                    context.push(Paths.profileHome);
                  },
                  child: Row(
                    children: [
                      const LzImage('profile.jpg', radius: 50, size: 50,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Textr(
                            '$fistName $lastName',
                            width: 200,
                            maxLines: 1,
                            overflow: Tof.clip,
                            style: Gfont.bold.white,
                          ),
                          Textr(
                            email,
                            width: 200,
                            maxLines: 1,
                            overflow: Tof.clip,
                            style: Gfont.white.fsize(12),
                          )
                        ],
                      ).margin(l: 15),
                    ],
                  ),
                ),
              ),
              Positioned(                              
                  top: 50,
                  right: 25,
                  child: IconButton(
                      onPressed: () {
                        context.push(Paths.notificationHome);
                      },
                      icon: const Icon(
                        Ti.bell,
                        size: 30,
                        color: Colors.white,
                      ))),
              Container(
                margin: Ei.only(t: 160),
                width: context.width,
                height: context.height,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
              ),
              const SaldoHome(),
              const Column(
                mainAxisAlignment: Maa.start,
                children: [
                  Row(
                    mainAxisSize: Mas.min,
                    children: [
                      BalanceWithDrawl(),
                      RecentTransaction()
                    ],
                  ),
                  YourProjectHome(),
                  AllProjectHome()
                ],
              ).margin(l: 25, r: 25, t: 220),
            ],
          );
        },
        error: (error, _) {
          return LzNoData(message: 'Oops! $error');
        },
        loading: () {
          return LzLoader.bar(message: 'Loading...');
        },
      ),
    );
  }
}
