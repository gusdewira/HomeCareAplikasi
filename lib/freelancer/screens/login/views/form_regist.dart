import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../../providers/login/register_provider.dart';
import '../../../widgets/color_widget.dart';

class RegistView extends ConsumerStatefulWidget {
  const RegistView({super.key});

  @override
  ConsumerState<RegistView> createState() => _RegistViewState();
}

class _RegistViewState extends ConsumerState<RegistView> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(registerProvider.notifier);
    String selectedRole = 'freelancer';
    final List<String> roles = ['freelancer', 'employer'];

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
          SizedBox(
            height: 130,
            width: context.width,
            child: const LzImage(
              'glombangAtas.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 730,
            child: Column(
              mainAxisSize: Mas.min,
              crossAxisAlignment: Caa.start,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: Mas.min,
                    children: [
                      Text(
                        'Regist',
                        style: Gfont.bold.fsize(24),
                      ),
                      Row(
                        mainAxisAlignment: Maa.center,
                        children: [
                          Textr(
                            'You already have an account?',
                            style: Gfont.bold.fsize(12),
                            margin: Ei.only(t: 10),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '  Login',
                              style: Gfont.color(colorLogin).bold.fsize(16),
                            ).margin(t: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                LzForm.input(
                  label: 'First name',
                  labelStyle: LzFormLabelStyle(color: color1),
                  hint: 'Input your first name',
                  model: notifier.forms['first_name'],
                ).margin(t: 20),
                LzForm.input(
                  label: 'Last name',
                  labelStyle: LzFormLabelStyle(color: color1),
                  hint: 'Input your last name',
                  model: notifier.forms['last_name'],
                ),
                LzForm.input(
                  label: 'Address',
                  labelStyle: LzFormLabelStyle(color: color1),
                  hint: 'Input your address',
                  model: notifier.forms['address'],
                ),
                LzForm.input(
                  label: 'Phone number',
                  labelStyle: LzFormLabelStyle(color: color1),
                  hint: 'Input your phone number',
                  model: notifier.forms['number_phone'],
                ),
                LzForm.input(
                  label: 'Email',
                  labelStyle: LzFormLabelStyle(color: color1),
                  hint: 'Input your email',
                  model: notifier.forms['email'],
                ),
                LzForm.input(
                  label: 'Password',
                  labelStyle: LzFormLabelStyle(color: color1),
                  hint: 'Create Your Password',
                  obsecureToggle: true,
                  model: notifier.forms['password'],
                ),
                LzForm.input(
                  label: 'Retype password',
                  labelStyle: LzFormLabelStyle(color: color1),
                  hint: 'Retype your password',
                  obsecureToggle: true,
                  model: notifier.forms['retype_password'],
                ),
                Center(
                  child: const Text(
                    'Role User',
                    style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                  ).margin(t: 20, b: 10),
                ),
                RadioGroup<String>.builder(
                  groupValue: selectedRole,
                  horizontalAlignment: MainAxisAlignment.spaceAround,
                  direction: Axis.horizontal,
                  onChanged: (value) => setState(() {
                    notifier.forms['role']?.controller.text = value!;
                    (context as Element).markNeedsBuild();
                  }),
                  items: roles,
                  itemBuilder: (item) => RadioButtonBuilder(item),
                ),
              ],
            ).margin(l: 25, r: 25),
          ),
          Stack(
            children: [
              Container(
                margin: Ei.only(t: 20, l: 25, r: 25),
                width: context.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    notifier.register(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(colorLogin),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: Gfont.bold.white.fsize(15),
                  ),
                ),
              ),
              Container(
                margin: Ei.only(t: 200),
                width: MediaQuery.of(context).size.width,
                height: 170,
                child: const LzImage(
                  'glombang.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: LzImage(
                  'logoHomecare.png',
                ),
              ).margin(t: 140),
            ],
          ),
        ],
      ),
    );
  }
}
