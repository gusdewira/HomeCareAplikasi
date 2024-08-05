import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/experience_model.dart';
import '../../../providers/setting/experience_provider.dart';
import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';
import '../widgets/addmore_experience.dart';

class Tabbar1MyProfile extends ConsumerWidget {
  const Tabbar1MyProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(experienceProvider);

    return Column(
      children: [
        Container(
          margin: Ei.only(l: 25, r: 25, b: 20),
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
                'Add More Experience',
                alignment: Alignment.centerLeft,
                padding: Ei.all(10),
              ),
              InkTouch(
                onTap: () {
                  context.push(Paths.addmoreexperience);
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
            data: (List<ExperienceModel> experiences) {
              return experiences.isNotEmpty
                  ? ListView.builder(
                      itemCount: experiences.length,
                      itemBuilder: (context, index) {
                        final experience = experiences[index];
                        int id = experience.id ?? 0;
                        String title = experience.title ?? '';
                            String description = experience.description ?? '';
                            String startDate = experience.startDate.format('dd MMM yyyy');
                            String endDate = experience.endDate.format('dd MMM yyyy');
                            String company = experience.company ?? '';
          
                       return Container(
                              margin: Ei.only( b: 20, l: 25, r: 25),
                              height: 160,
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
                                ],
                              ),
                              child: Column(
                                mainAxisSize: Mas.min,
                                crossAxisAlignment: Caa.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: Maa.spaceBetween,
                                    children: [
                                      Textr(
                                        title,
                                        style:
                                            Gfont.color(color1)
                                                .fsize(12),
                                        width: context.width / 2 - 40,
                                        maxLines: 1,
                                        overflow: Tof.ellipsis,
                                      ),
                                      Textr(
                                        '$startDate - $endDate',
                                        style:
                                            Gfont.color(LzColors.hex('000000'))
                                                .fsize(10),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: Maa.spaceBetween,
                                    children: [
                                      Textr(
                                        company,
                                        width: context.width / 2 - 50,
                                        maxLines: 1,
                                        overflow: Tof.ellipsis,
                                        style:
                                            Gfont.color(black)
                                                .fsize(12),
                                      ),
                                      PopupMenuButton<String>(
                                        icon: const Icon(Ti.dots),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                              leading: Icon(Ti.trash,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ],
                                        onSelected: (String value) {
                                          if (value == 'edit') {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddMoreExperience(
                                                  data: experience, edit: true,
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
                                                  radius:
                                                      BorderRadius.circular(25),
                                                  onConfirm: () {
                                                    ref
                                                        .read(experienceProvider
                                                            .notifier)
                                                        .delEx(id);
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
                                    maxLines: 4,
                                    overflow: Tof.ellipsis,
                                    margin: Ei.only(r: 30),
                                  ),
                                ],
                              ).margin(l: 15, r: 25, t: 15, ),
                            );
                      },
                    )
                  : const LzNoData(
                      message:
                          'There is no data yet, please add data in the add experience menu', 
                          iconWidget: Icon(Ti.alertTriangle, color: Colors.grey, size: 50));
            },
            error: (error, _) {
              ref.read(experienceProvider.notifier).getEx();
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
