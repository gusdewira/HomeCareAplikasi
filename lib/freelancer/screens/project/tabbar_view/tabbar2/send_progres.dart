import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:homecare_app/employer/providers/notification_provider.dart';
import 'package:homecare_app/freelancer/providers/explore/detail_project_provider.dart';
import 'package:homecare_app/freelancer/providers/project/history_progress_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';
import '../../../../data/models/setting/project_freelancer_model.dart';
import '../../../../widgets/color_widget.dart';

class SendProgressProject extends ConsumerWidget {
  final int id;
  final int offer;
  const SendProgressProject({super.key, required this.id, required this.offer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailProject = ref.watch(detailProjectFreelancer(id));
    final notifier = ref.watch(progressPostProvider.notifier);
    final notification = ref.read(notificationProgressProvider.notifier);
    final forms = notifier.forms;

    return detailProject.when(data: (ProjectFreelancerModel detail) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                LzColors.hex('11B0E6'),
                LzColors.hex('3265FF'),
              ],
              stops: const [
                0.0,
                0.6
              ]),
        ),
        child: LzFormList(
          cleanOnFilled: true,
          style: LzFormStyle(
            activeColor: LzColors.dark,
            inputBorderColor: Colors.black26,
            type: FormType.topInner,
          ),
          padding: Ei.zero,
          children: [
            Stack(
              children: [
                Container(
                  margin: Ei.only(t: 120),
                  width: context.width,
                  height: context.height,
                  decoration: BoxDecoration(
                      color: LzColors.hex('F8F8FF'),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                ),
                Positioned(
                  top: 50,
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
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Center(
                        child: Textr(
                      'Send Progress Project',
                      style: Gfont.white.bold.fsize(18),
                    ))),
                Column(
                  crossAxisAlignment: Caa.start,
                  children: [
                    Textr(
                      "${detail.title}",
                      margin: Ei.only(b: 10),
                      width: context.width / 2 + 20,
                      maxLines: 1,
                      style: Gfont.color(LzColors.hex('000000')).bold,
                    ),
                    SizedBox(
                      width: context.width,
                      child: Row(
                        mainAxisAlignment: Maa.spaceBetween,
                        children: [
                          Text(
                            'Start date : ${DateFormat('dd-MM-yyyy').format(detail.startDate!)}',
                            style: Gfont.fs12.bold,
                          ),
                          Text(
                            'End date : ${DateFormat('dd-MM-yyyy').format(detail.endDate!)}',
                            style: Gfont.fs12.bold,
                          )
                        ],
                      ).margin(b: 20),
                    ),
                    Container(
                      width: context.width,
                      height: 1,
                      color: Colors.black54,
                    ),
                    LzForm.input(
                            label: 'Title',
                            labelStyle: LzFormLabelStyle(color: color1),
                            hint: 'Input Title',
                            model: forms['title'])
                        .margin(t: 20),
                    SizedBox(
                      height: 70,
                      width: context.width,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black26),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: OverflowBox(
                                  alignment: Alignment.topLeft,
                                  maxHeight: double.infinity,
                                  child: Padding(
                                    padding: Ei.only(h: 13.0),
                                    child: Row(
                                      mainAxisAlignment: Maa.spaceBetween,
                                      children: [
                                        if (notifier.fileAttachment != null)
                                          Flexible(
                                            flex: 10,
                                            child: Textr(
                                              'Picked file: ${notifier.fileAttachment!.path.split('/file_picker/')[1]}',
                                              style: Gfont.black.fsize(7),
                                              padding: Ei.only(v: 10),
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ),
                                        Row(
                                          mainAxisAlignment: Maa.end,
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                FilePickerResult? result =
                                                    await FilePicker.platform
                                                        .pickFiles();
                                                if (result != null) {
                                                  File file = File(result
                                                          .files.single.path ??
                                                      '');
                                                  notifier.setFile(file);
                                                }
                                              },
                                              icon: const Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  Ti.upload,
                                                  size: 25,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 15,
                            top: 0,
                            child: Textr(
                              'Attachment',
                              style: Gfont.color(color1.lighten(0.72))
                                  .bold
                                  .fsize(13),
                            ),
                          ),
                        ],
                      ),
                    ),
                    LzForm.input(
                        label: 'Description',
                        labelStyle: LzFormLabelStyle(color: color1),
                        hint: 'Input Description',
                        model: forms['description']),
                    SizedBox(
                      width: double.infinity,
                      child: LzButton(
                        radius: 20,
                        color: color1,
                        text: 'Send',
                        textColor: Colors.white,
                        onTap: (state) async {
                          state.submit();
                          ResHandler ok = await notifier.progressPost(
                              context, '${detail.id!}');

                          if (ok.status) {
                            LzToast.show("Progress has been created.");

                            await notification.postNotification({
                              "sent_to": detail.user!['id'],
                              "project_id": detail.id!,
                              "notif_text": "made",
                              "is_read": 1,
                              "progresses_id": ok.data['id'],
                              "offer_id": offer
                            });

                            Navigator.of(context).pop();
                          } else {
                            state.abort();
                            LzToast.show("Please fill all required fields.");
                          }
                        },
                      ).margin(b: 50),
                    )
                  ],
                ).margin(t: 140, l: 25, r: 25)
              ],
            ),
          ],
        ),
      );
    }, error: (error, _) {
      return LzNoData(message: 'Oops! $error');
    }, loading: () {
      return LzLoader.bar(message: 'Loading...');
    });
  }
}
