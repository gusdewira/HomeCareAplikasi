import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/experience_model.dart';
import '../../../providers/setting/experience_provider.dart';
import '../../../widgets/color_widget.dart';

class AddMoreExperience extends ConsumerWidget {
  final ExperienceModel? data;
  bool? edit = false;

  AddMoreExperience({Key? key, this.data, this.edit}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(experienceProvider.notifier);
    final forms = notifier.forms;

    if (!data.hasNull) {
      forms.fill(data!.toJson());
    }else{
      forms.reset();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${edit != null && edit == true ? "Edit" : "Add"} More Experience'),
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
                maxLength: 2000,
                model: forms['title'],
              ),
              LzForm.input(
                label: 'Company',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'Input Company',
                maxLength: 2000,
                model: forms['company'],
              ),
              LzForm.input(
                label: 'Description',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'Input Description',
                maxLength: 2000,
                model: forms['description'],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: Ei.only(r: 5),
                      child: LzForm.input(
                        label: 'Start Date',
                        labelStyle: LzFormLabelStyle(color: color1),
                        hint: 'Enter start date',
                        maxLines: 2,
                        model: forms['start_date'],
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
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: Ei.only(l: 5),
                      child: LzForm.input(
                        label: 'End Date',
                        labelStyle: LzFormLabelStyle(color: color1),
                        hint: 'Enter end date',
                        maxLines: 2,
                        model: forms['end_date'],
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ).margin(t: 20, r: 25, l: 25),
      bottomNavigationBar: LzButton(
        radius: 20,
        color: color1,
        textColor: Colors.white,
        text: 'Save',
        onTap: (state) async {
          state.submit();
          bool ok = await notifier.postEx(data?.id);

          if (ok && context.mounted) {
            context.pop();
            LzToast.show(data?.id == null
                ? 'Experience has been created.'
                : 'Experience has been updated.');
          }else{
            state.abort();
          }
        },
      ).theme1().margin(b: 50),
    );
  }
}
