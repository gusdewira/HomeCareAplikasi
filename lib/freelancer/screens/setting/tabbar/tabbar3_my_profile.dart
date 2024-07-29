import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/skill_model.dart';
import '../../../providers/setting/skill_provider.dart';
import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';
import '../widgets/addmore_skills.dart';

class Tabbar3MyProfile extends ConsumerWidget {
  const Tabbar3MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(skillProvider);

    return Column(
      children: [
        Container(
          margin:Ei.only(l: 25, r: 25, b: 20),
          width: context.width,
          height: 40,
          decoration: BoxDecoration(
            color: LzColors.hex('E6E6E8'),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Textr(
                'Add More skill',
                alignment: Alignment.centerLeft,
                padding: Ei.all(10),
              ),
              InkTouch(
                onTap: () {
                  context.push(Paths.addmoreskills);
                },
                child: Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                    color: LzColors.hex('006FFF'),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: profileData.when(
            data: (List<SkillModel> skills) {
              return skills.isNotEmpty
                  ? ListView.builder(
                      itemCount: skills.length,
                      itemBuilder: (context, index) {
                        final skill = skills[index];
                        int id = skill.id;
                        String skillName = skill.skillName;
                        String description = skill.description;

                        return Container(
                          margin: Ei.only( b: 20, l: 25, r: 25),
                          height: 130,
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
                              Row(
                                mainAxisAlignment: Maa.spaceBetween,
                                children: [
                                  Textr(
                                    skillName,
                                    
                                    width: context.width / 2 - 50,
                                    maxLines: 1,
                                    overflow: Tof.ellipsis,
                                    style: Gfont.color(color1).fsize(12),
                                  ),
                                  PopupMenuButton<String>(
                                    icon: const Icon(Ti.dots),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    offset: const Offset(25, 20),
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'edit',
                                        child: ListTile(
                                          title: Text('Edit'),
                                          leading: Icon(Ti.pencil,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'delete',
                                        child: ListTile(
                                          title: Text('Delete'),
                                          leading:
                                              Icon(Ti.trash, color: Colors.red),
                                        ),
                                      ),
                                    ],
                                    onSelected: (String value) {
                                      if (value == 'edit') {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => AddMoreSkill(
                                              data: skill, edit: true
                                            ),
                                          ),
                                        );
                                      } else if (value == 'delete') {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return LzConfirm(
                                              title: "Warning",
                                              message:
                                                  'Are You Sure To Delete This Data?',
                                              titleSize: 15,
                                              icon: Ti.alertTriangle,
                                              iconColor: Colors.red,
                                              radius: BorderRadius.circular(25),
                                              onConfirm: () {
                                                ref
                                                    .read(
                                                        skillProvider.notifier)
                                                    .delSkill(id);
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Textr(
                                description,
                                  style: Gfont.color(Colors.grey)
                                      .fsize(12),
                                  maxLines: 3,
                                  overflow: Tof.ellipsis,
                                  margin: Ei.only(r: 30)),
                            ],
                          ).margin(l: 15, r: 25),
                        );
                      },
                    )
                  : const LzNoData(
                      message:
                          'There is no data yet, please add data in the add experience menu', 
                          iconWidget: Icon(Ti.alertTriangle, color: Colors.grey, size: 50));
            },
            error: (error, _) {
              // Perbaiki dan lengkapi penanganan error
              ref.read(skillProvider.notifier).getSkil();
              return LzNoData(message: 'Oops! $error');
            },
            loading: () {
              return LzLoader.bar(message: 'Loading...');
            },
          ),
        ),
      ],
    );
  }
}
