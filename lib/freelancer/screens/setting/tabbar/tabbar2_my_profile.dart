import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/qualification_model.dart';
import '../../../providers/setting/qualification_provider.dart';
import '../../../widgets/color_widget.dart';
import '../widgets/addmore_qualification.dart';

class Tabbar2MyProfile extends ConsumerWidget {
  // ignore: use_key_in_widget_constructors
  const Tabbar2MyProfile({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<QualificationModel>> qualificationData =
        ref.watch(qualificationProvider);

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
              const Textr(
                'Add More Qualification',
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10),
              ),
              InkTouch(
                onTap: () {
                  context.lzPush(const AddMoreQualification());
                },
                child: Container(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                      color: LzColors.hex('006FFF'),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Icon(
                    Ti.plus,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: qualificationData.when(
            data: (List<QualificationModel> qualifications) {
              return qualifications.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: qualifications.length,
                      itemBuilder: (context, index) {
                        final qualification = qualifications[index];
                        int? id = qualification.id;
                        String title = qualification.title;
                        String orgQualification =
                            qualification.orgQualification;
                        String date = qualification.date.format('dd MMM yyyy');
                        String attchment = qualification.attachment;

                        return Container(
                          margin: Ei.only(l: 25, r: 25, b: 20),
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
                                    style: Gfont.color(color1).fsize(12),
                                  ),
                                  Textr(
                                    date,
                                    style: Gfont.color(LzColors.hex('000000'))
                                        .fsize(10),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: Maa.spaceBetween,
                                children: [
                                  Textr(
                                    orgQualification,
                                    width: context.width / 2 - 50,
                                    maxLines: 1,
                                    overflow: Tof.ellipsis,
                                    style: Gfont.color(black).fsize(12),
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
                                            builder: (context) =>
                                                AddMoreQualification(
                                              data: qualification, edit: true,
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
                                                    .read(qualificationProvider
                                                        .notifier)
                                                    .delete(id ?? 0);
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                margin: Ei.only(t: 10),
                                padding: Ei.all(8),
                                height: 40,
                                width: context.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: LzColors.hex('9B9B9B'))),
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
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Textr(
                                          'Download',
                                          style: Gfont.color(
                                                  LzColors.hex('000000'))
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
                          'There is no data yet, please add data in the add experience menu',
                      iconWidget:
                          Icon(Ti.alertTriangle, color: Colors.grey, size: 50));
            },
            error: (error, _) {
              ref.read(qualificationProvider.notifier).getQualif();
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
