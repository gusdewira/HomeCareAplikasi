import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/skill_model.dart';
import '../../../providers/setting/skill_provider.dart';
import '../../../widgets/color_widget.dart';

class AddMoreSkill extends ConsumerWidget {
  final SkillModel? data;
  bool? edit = false;

  AddMoreSkill({super.key, this.data, this.edit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(skillProvider.notifier);
    final forms = notifier.forms;

    if (!data.hasNull) {
      forms.fill(data!.toJson());
    }else{
      forms.reset();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${edit != null && edit == true ? "Edit" : "Add"} More skill'),
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
              label: 'Skill Name',
              labelStyle: LzFormLabelStyle(color: color1),
              hint: 'Input Title',
              maxLength: 2000,
              model: forms['skill_name'],
            ).margin(t: 20),
            LzForm.input(
              label: 'Description',
              labelStyle: LzFormLabelStyle(color: color1),
              hint: 'Input Description',
              maxLength: 2000,
              model: forms['description'],
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
          bool ok = await notifier.postSkil(data?.id);

          if (ok && context.mounted) {
            context.pop();
            LzToast.show(data?.id == null
                ? 'Skill has been created.'
                : 'skill has been updated.');
          }else{
            state.abort();
            LzToast.show("Please fill all required fields.");
          }
        },
      ).theme1().margin(b: 50),
    );
  }
}
