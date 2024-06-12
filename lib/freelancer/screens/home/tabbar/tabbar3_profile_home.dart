import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/skill_model.dart';
import '../../../providers/setting/skill_provider.dart';
import '../../../widgets/color_widget.dart';

class Tabbar3Profilehome extends ConsumerWidget {
  const Tabbar3Profilehome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(skillProvider);

    return profileData.when(
      data: (List<SkillModel> skills) {
        return skills.isNotEmpty
            ? ListView.builder(
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  final skill = skills[index];
                  String skillName = skill.skillName;
                  String description = skill.description;
    
                  return Container(
                    margin: Ei.only(l: 25, r: 25, b: 20),
                    height: 120,
                    width: context.width / 1,
                    decoration: BoxDecoration(
                        color: LzColors.hex('FFFFFF'),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 10,
                          )
                        ]),
                    child: Column(
                      mainAxisSize: Mas.min,
                      crossAxisAlignment: Caa.start,
                      children: [
                        Textr(
                          skillName,
                          width: context.width / 2 - 50,
                          maxLines: 1,
                          overflow: Tof.ellipsis,
                          style: Gfont.color(color1).fsize(12),
                          margin: Ei.only(t: 10, b: 10),
                        ),
                        Textr(
                          description,
                            style: Gfont.color(Colors.grey)
                                .fsize(12),
                            maxLines: 4,
                            overflow: Tof.ellipsis,
                            margin: Ei.only(r: 30)),
                      ],
                    ).margin(l: 15, r: 25),
                  );
                },
              )
            : const LzNoData(
                message:
                    'There is no data yet, please add data in the add skill menu');
      },
      error: (error, _) {
        // Perbaiki dan lengkapi penanganan error
        ref.read(skillProvider.notifier).getSkil();
        return LzNoData(message: 'Oops! $error');
      },
      loading: () {
        return LzLoader.bar(message: 'Loading...');
      },
    );
  }
}