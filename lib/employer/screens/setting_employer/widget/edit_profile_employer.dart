import 'package:flutter/material.dart';
import 'package:homecare_app/employer/providers/profile_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

class EditProfileEmployer extends ConsumerWidget {
  const EditProfileEmployer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(editProfilChangeNotifier.notifier);
    final data = ref.watch(profileEmployeeProvider);

    return data.when(
      data: (data) {
        notifier.fillForm(data);
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
                Column(
                  children: [
                    Container(
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
                            margin: Ei.only(t: 150),
                            width: context.width,
                            height: context.height,
                            decoration: BoxDecoration(
                                color: color2,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Positioned(
                              top: 50,
                              left: 0,
                              right: 0,
                              child: Center(
                                  child: Textr(
                                'Edit Profile',
                                style: Gfont.white.bold.fsize(18),
                              ))),
                          Positioned(
                              top: 110,
                              left: 0,
                              right: 0,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.white, width: 4)),
                                    child: const LzImage('profile.jpg',
                                        size: 80, radius: 40),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: Ei.only(l: 5, r: 5),
                                    height: 35,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color: LzColors.hex('0047E3'),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Ti.edit,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        Text(
                                          'change photo',
                                          style: Gfont.white.fsize(15),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      LzForm.input(
                                          label: 'First Name',
                                          labelStyle:
                                              LzFormLabelStyle(color: color1),
                                          hint: 'first name',
                                          model: notifier.forms["first_name"]),
                                      LzForm.input(
                                        label: 'Last Name',
                                        labelStyle:
                                            LzFormLabelStyle(color: color1),
                                        hint: 'last name',
                                        model: notifier.forms["last_name"],
                                      ),
                                      LzForm.input(
                                        label: 'profession',
                                        labelStyle:
                                            LzFormLabelStyle(color: color1),
                                        hint: 'profession',
                                        model: notifier.forms["profession"],
                                      ),
                                      LzForm.input(
                                        label: 'email',
                                        labelStyle:
                                            LzFormLabelStyle(color: color1),
                                        hint: 'email',
                                        model: notifier.forms["email"],
                                      ),
                                      LzForm.input(
                                        label: 'address',
                                        labelStyle:
                                            LzFormLabelStyle(color: color1),
                                        hint: 'address',
                                        maxLength: 100,
                                        model: notifier.forms["address"],
                                      ),
                                      LzForm.input(
                                        label: 'number phone',
                                        labelStyle:
                                            LzFormLabelStyle(color: color1),
                                        hint: 'number_phone',
                                        keyboard: const TextInputType
                                            .numberWithOptions(),
                                        maxLength: 13,
                                        model: notifier.forms["number_phone"],
                                      ),
                                    ],
                                  ).margin(t: 10, l: 25, r: 25, b: 50),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: LzButton(
              radius: 20,
              color: color1,
              textColor: Colors.white,
              text: 'Update',
              onTap: (state) async {
                notifier.edit(context, data.id!);
              },
            ).theme1().margin(b: 10));
      },
      error: (error, _) {
        return LzNoData(message: 'Oops! $error');
      },
      loading: () {
        return LzLoader.bar(message: 'Loading...');
      },
    );
  }
}
