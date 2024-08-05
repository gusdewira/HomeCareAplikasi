import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/providers/project_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

class PostingProjectEmployer extends ConsumerWidget {
  const PostingProjectEmployer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? getValidCategoryValue(String? currentValue) {
      const validCategories = [
        'Mobile App Development',
        'Content Writing',
        'Digital Marketing',
        'Video Editing',
        'UI/UX Design',
        'Game Development',
        'Data Entry',
        'Virtual Assistance',
      ];
      if (currentValue != null && validCategories.contains(currentValue)) {
        return currentValue;
      }
      return null;
    }

    final List<Map<String, String>> salaryRanges = [
      {'start': '- Please Select Range', 'end': ''},
      {'start': '200.000', 'end': '350.000'},
      {'start': '350.000', 'end': '500.000'},
      {'start': '500.000', 'end': '1.000.000'},
      {'start': '1.000.000', 'end': '2.500.000'},
      {'start': '2.500.000', 'end': '4.000.000'},
      {'start': '4.000.000', 'end': '5.500.000'},
    ];

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
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Category',
                                labelStyle: TextStyle(color: color1),
                                hintText: 'Select Project Category',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: color1,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                isDense: true,
                              ),
                              value: getValidCategoryValue(notifier
                                  .forms['name_category']?.controller.text),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  notifier.forms['name_category']?.controller
                                      .text = newValue;
                                  notifier.notifyListeners();
                                }
                              },
                              items: [
                                'Mobile App Development',
                                'Content Writing',
                                'Digital Marketing',
                                'Video Editing',
                                'UI/UX Design',
                                'Game Development',
                                'Data Entry',
                                'Virtual Assistance'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 8,
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
                                model.text = date.format();
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
                                model.text = date.format();
                              },
                            ),
                            DropdownButtonFormField<Map<String, String>>(
                              decoration: InputDecoration(
                                labelText: 'Salary Range',
                                labelStyle: TextStyle(color: color1),
                                hintText: 'Select Salary Range',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: color1,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                              ),
                              value: salaryRanges[0],
                              onChanged: (Map<String, String>? newValue) {
                                if (newValue!['end'] != null || newValue['end'] == '') {
                                  notifier.forms['start_salary']?.controller
                                      .text = newValue['start']!;
                                  notifier.forms['end_salary']?.controller
                                      .text = newValue['end']!;
                                  notifier.notifyListeners();
                                }
                              },
                              items: salaryRanges
                                  .map<DropdownMenuItem<Map<String, String>>>(
                                      (Map<String, String> value) {
                                return DropdownMenuItem<Map<String, String>>(
                                  value: value,
                                  child: Text(
                                      '${value['start']} - ${value['end']}'),
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 32,
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
