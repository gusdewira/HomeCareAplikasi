import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/providers/project_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

class PostingProjectEmployer extends ConsumerWidget {
  const PostingProjectEmployer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(postProjectNotifier.notifier);
    return Scaffold(
      body: LzFormList(
        cleanOnFilled: true,
        style: LzFormStyle(
          activeColor: LzColors.dark,
          inputBorderColor: Colors.black26,
          type: FormType.topInner,
        ),
        padding: Ei.zero,
        children: [
          Expanded(
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
                    width: context.width,
                    height: context.height,
                    decoration: BoxDecoration(
                      color: color2,
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 50,
                      left: 0,
                      right: 0,
                      child: Center(
                          child: Textr(
                        'Posting Project',
                        style: Gfont.black.bold.fsize(18),
                      ))),
                  Positioned(
                      top: 100,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            LzForm.input(
                                label: 'Project Title',
                                labelStyle: LzFormLabelStyle(color: color1),
                                hint: 'Project Title',
                                model: notifier.forms['title']),
                            LzForm.input(
                                label: 'Project Description',
                                labelStyle: LzFormLabelStyle(color: color1),
                                hint: 'Project Description',
                                model: notifier.forms['description']),
                            LzForm.input(
                              label: 'Category',
                              labelStyle: LzFormLabelStyle(color: color1),
                              hint: 'Project Category',
                              model: notifier.forms['name_category'],
                              maxLength: 100,
                            ),
                            SizedBox(
                              height: 70,
                              width: context.width,
                              child: Stack(children: [
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
                                              if (notifier.fileAttachment !=
                                                  null)
                                                Flexible(
                                                  flex: 10,
                                                  child: Textr(
                                                    'Picked file: ${notifier.fileAttachment!}',
                                                    style: Gfont.black.fsize(7),
                                                    padding: Ei.only(v: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                ),
                                              Row(
                                                mainAxisAlignment: Maa.end,
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      FilePickerResult? result =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles();

                                                      if (result != null) {
                                                        File file = File(result
                                                                .files
                                                                .single
                                                                .path ??
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
                              ]),
                            ),
                            LzForm.input(
                              label: 'Project Location',
                              labelStyle: LzFormLabelStyle(color: color1),
                              hint: 'Longitude',
                              model: notifier.forms['longitude'],
                              maxLength: 2000,
                            ),
                            LzForm.input(
                              label: 'Project Location',
                              labelStyle: LzFormLabelStyle(color: color1),
                              hint: 'Latitude',
                              model: notifier.forms['latitude'],
                              maxLength: 2000,
                            ),
                            LzForm.input(
                              label: 'Start Date',
                              labelStyle: LzFormLabelStyle(color: color1),
                              hint: 'Enter Date',
                              maxLines: 2,
                              model: notifier.forms['start_date'],
                              suffixIcon: Ti.calendar,
                              onTap: (model) async {
                                DateTime? date = await LzPicker.datePicker(
                                  context,
                                  minDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month - 1,
                                    DateTime.now().day - 30,
                                  ),
                                );
                                if (date != null) {
                                  model.text = date.format();
                                }
                              },
                            ),
                            LzForm.input(
                              label: 'End Date',
                              labelStyle: LzFormLabelStyle(color: color1),
                              hint: 'Enter Date',
                              maxLines: 2,
                              model: notifier.forms['end_date'],
                              suffixIcon: Ti.calendar,
                              onTap: (model) async {
                                DateTime? date = await LzPicker.datePicker(
                                  context,
                                  minDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month - 1,
                                    DateTime.now().day - 30,
                                  ),
                                );
                                if (date != null) {
                                  model.text = date.format();
                                }
                              },
                            ),
                            LzForm.input(
                              label: 'Start Salary',
                              labelStyle: LzFormLabelStyle(color: color1),
                              hint: 'Start Salary',
                              model: notifier.forms['start_salary'],
                              maxLength: 2000,
                            ),
                            LzForm.input(
                              label: 'End Salary',
                              labelStyle: LzFormLabelStyle(color: color1),
                              hint: 'End Salary',
                              model: notifier.forms['end_salary'],
                              maxLength: 2000,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: LzButton(
                                radius: 20,
                                color: color1,
                                text: 'Save',
                                textColor: Colors.white,
                                onTap: (state) async {
                                  state.submit();
                                  bool ok = await notifier.create(context);

                                  if (ok && context.mounted) {
                                    context.pop();
                                    LzToast.show("Project has been created.");
                                  } else {
                                    state.abort();
                                    LzToast.show(
                                        "Please fill all required fields.");
                                  }
                                },
                              ).theme1(),
                            ),
                          ],
                        ).margin(t: 10, l: 25, r: 25, b: 50),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}