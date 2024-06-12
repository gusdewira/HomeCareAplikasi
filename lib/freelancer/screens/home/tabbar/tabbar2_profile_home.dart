import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/qualification_model.dart';
import '../../../providers/setting/qualification_provider.dart';
import '../../../widgets/color_widget.dart';

class Tabbar2ProfileHome extends ConsumerWidget {
  const Tabbar2ProfileHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<QualificationModel>> qualificationData =
        ref.watch(qualificationProvider);

        
    return qualificationData.when(
      data: (List<QualificationModel> qualifications) {
        return qualifications.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: qualifications.length,
                itemBuilder: (context, index) {
                  final qualification = qualifications[index];
                  String title = qualification.title;
                  String orgQualification = qualification.orgQualification;
                  String date = qualification.date.format('dd MMM yyyy');
                  String attchment = qualification.attachment;
    
                  return Container(
                    margin: Ei.only(b: 20, l: 25, r: 25),
                    height: 145,
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
                              title,
                              style: Gfont.color(color1)
                                  .fsize(12),
                            ),
                            Textr(
                              date,
                              style: Gfont.color(LzColors.hex('000000'))
                                  .fsize(10),
                            )
                          ],
                        ),
                        Textr(
                          orgQualification,
                          width: context.width / 2 - 50,
                          margin: Ei.only(t: 10, b: 10),
                          maxLines: 1,
                          overflow: Tof.ellipsis,
                          style: Gfont.color(black).fsize(12),
                        ),
                        Container(
                          margin: Ei.only(t: 10),
                          padding: Ei.all(8),
                          height: 40,
                          width: context.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1, color: LzColors.hex('9B9B9B'))),
                          child: Row(
                            mainAxisAlignment: Maa.spaceBetween,
                            children: [
                              Textr(
                                attchment,
                                style: Gfont.color(LzColors.hex('A9A6CD'))
                                    .fsize(15),
                                width: 200,
                              ),
                              InkTouch(
                                onTap: () {},
                                child: Container(
                                  padding: Ei.all(5),
                                  decoration: BoxDecoration(
                                      color: LzColors.hex('FFD700'),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Textr(
                                    'Download',
                                    style: Gfont.color(LzColors.hex('000000'))
                                        .fsize(10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ).margin(l: 15, r: 25, t: 15),
                  );
                },
              )
            : const LzNoData(
                message:
                    'There is no data yet, please add data in the add experience menu');
      },
      error: (error, _) {
        ref.read(qualificationProvider.notifier).getQualif();
        return LzNoData(message: 'Oops! $error');
      },
      loading: () {
        return LzLoader.bar(message: 'Loading...');
      },
    );
  }
}
