import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide MultipartFile;
import '../../../data/models/setting/qualification_model.dart';
import '../../../providers/setting/qualification_provider.dart';
import '../../../widgets/color_widget.dart';

class AddMoreQualification extends ConsumerWidget {
  final QualificationModel? data;

  const AddMoreQualification({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(qualificationPostProvider.notifier);
    final forms = notifier.forms;

    if (!data.hasNull) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add More Qualification'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
        ),
        elevation: 0.0,
      ),
      body: LzFormList(
        cleanOnFilled: true,
        style: LzFormStyle(
          activeColor: LzColors.dark,
          inputBorderColor: Colors.black26,
          type: FormType.topInner,
        ),
        padding: Ei.zero,
        children: [
          Column(
            children: [
              LzForm.input(
                label: 'Title',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'Input Title',
                model: forms['title'],
              ).margin(t: 20),
              LzForm.input(
                label: 'Company',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'Input Company',
                model: forms['org_qualification'],
              ),
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
                            child: Container(
                              child: Padding(
                                padding: Ei.only(h: 13.0),
                                child: Row(
                                  mainAxisAlignment: Maa.spaceBetween,
                                  children: [
                                    if (notifier.fileAttachment != null)
                                      Flexible(
                                        flex: 10,
                                        child: Textr(
                                          'Picked file: ${notifier.fileAttachment!}',
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
                                              File file = File(
                                                  result.files.single.path ??
                                                      '');

                                              notifier.setFile(file);
                                            }
                                          },
                                          icon: Align(
                                            alignment: Alignment.centerRight,
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
                    ),
                    Positioned(
                      left: 15,
                      top: 0,
                      child: Textr(
                        'Attachment',
                        style: Gfont.color(color1.lighten(0.72)).bold.fsize(13),
                      ),
                    ),
                  ],
                ),
              ),
              LzForm.input(
                label: 'Date',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'Enter Date',
                maxLines: 2,
                model: forms['date'],
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
            ],
          )
        ],
      ).margin(t: 20, r: 25, l: 25),
      bottomNavigationBar: LzButton(
        radius: 20,
        color: color1,
        text: 'Save',
        textColor: Colors.white,
        onTap: (state) async {
          state.submit();
          bool ok = await notifier.qualifiPost(context);

          if (ok && context.mounted) {
            context.pop();
            LzToast.show("Qualification has been created.");
          }else{
            state.abort();
            LzToast.show("Please fill all required fields.");
          }
        },
      ).theme1().margin(b: 50),
    );
  }
}
