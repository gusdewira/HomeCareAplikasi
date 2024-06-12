import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/profile_freelancer_model.dart';
import '../../../providers/setting/profile_provider.dart';
import '../../../widgets/color_widget.dart';
import '../widgets/menu_setting.dart';

class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileFreelancerProvider);

    return RefreshIndicator(
      onRefresh: ()async{
        ref.read(profileFreelancerProvider.notifier);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [color3, color4],
              stops: const [0.0, 0.6]),
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
            String image = profile.photoProfile != null ? profile.photoProfile : 'profile.jpg';
            
      
            return Stack(
              children: [
                Container(
                  margin: Ei.only(t: 120),
                  width: context.width,
                  height: context.height,
                  decoration: BoxDecoration(
                      color: color2,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
                Positioned(
                    top: 50,
                    left: 25,
                    child: Textr(
                      'Setting',
                      style: Gfont.bold.white.fsize(25),
                    )),
                Positioned(
                    top: 85,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 4)),
                          child:
                               LzImage(image, size: 80, radius: 40),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$fistName $lastName',
                          style: Gfont.color(black).bold,
                        ),
                        Container(
                            margin: Ei.only(t: 5),
                            padding: Ei.only(l: 10, r: 10, b: 5, t: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: LzColors.hex('94BDFF').lighten(0.25)),
                            child: Text(
                              email,
                              style:
                                  Gfont.color(LzColors.hex('000000')).fsize(12),
                            )),
                        Container(
                            margin: Ei.only(l: 25, r: 25),
                            child: ListMenuSetting())
                      ],
                    )),
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
      ),
    );
  }
}
