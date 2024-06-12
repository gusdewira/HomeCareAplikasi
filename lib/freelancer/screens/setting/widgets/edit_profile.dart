// edit_profile.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/profile_freelancer_model.dart';
import '../../../providers/setting/edit_profile_provider.dart';
import '../../../widgets/color_widget.dart';

class EditProfile extends ConsumerWidget {
  final ProfileFreelancerModel? data;

  const EditProfile({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(editProfilChangeNotifier.notifier);

    if (data != null) {
      notifier.fillForm(data!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
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
                label: 'First Name',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'first name',
                model: notifier.forms["first_name"],
              ),
              LzForm.input(
                label: 'Last Name',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'last name',
                model: notifier.forms["last_name"],
              ),
              LzForm.input(
                label: 'profession',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'profession',
                model: notifier.forms["profession"],
              ),
              LzForm.input(
                label: 'email',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'email',
                model: notifier.forms["email"],
              ),
              LzForm.input(
                label: 'address',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'address',
                maxLength: 100,
                model: notifier.forms["address"],
              ),
              LzForm.input(
                label: 'number phone',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'number_phone',
                keyboard: const TextInputType.numberWithOptions(),
                maxLength: 13,
                model: notifier.forms["number_phone"],
              ),
              LzForm.input(
                label: 'earning',
                labelStyle: LzFormLabelStyle(color: color1),
                hint: 'earning',
                model: notifier.forms["earning"],
              ),
              LzForm.input(
                  label: 'summary',
                  labelStyle: LzFormLabelStyle(color: color1),
                  hint: 'summary',
                  maxLength: 2000,
                  model: notifier.forms["summary"],
                  ),
              
            ],
          ).margin(t: 10, l: 25, r: 25, b: 50),
        ],
      ),
      bottomNavigationBar: LzButton(
        radius: 20,
        color: color1,
        textColor: Colors.white,
        text: 'Update',
        onTap: (state) async {
          notifier.edit(context, data!.id ?? 0);
        },
      ).theme1().margin(b: 10),
    );
  }
}
