import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecare_app/freelancer/providers/setting/profile_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../../data/models/setting/profile_freelancer_model.dart';
import '../../../widgets/color_widget.dart';

class EditProfile extends ConsumerStatefulWidget {
  final ProfileFreelancerModel? data;

  const EditProfile({Key? key, this.data}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late ProfileFreelancerModel? data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    if (data != null) {
      final notifier = ref.read(editProfilChangeNotifier.notifier);
      notifier.fillForm(data!);
    }
  }

  Future<void> _refreshData() async {
    final profileProvider = ref.read(profileFreelancerProvider.notifier);
    await profileProvider.getProfile();
    final profileState = ref.read(profileFreelancerProvider);

    if (profileState is AsyncData<ProfileFreelancerModel>) {
      setState(() {
        data = profileState.value;
        final notifier = ref.read(editProfilChangeNotifier.notifier);
        notifier.fillForm(data!);
      });
    } else if (profileState is AsyncError) {
      print('Error: ${profileState.error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: LzFormList(
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
                                  child: LzImage(data!.photoProfile,
                                      size: 80, radius: 40),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkTouch(
                                  onTap: () {
                                    final notifier = ref.read(editProfilChangeNotifier.notifier);
                                    notifier.pickImage(context, data!.id!);
                                  },
                                  child: Container(
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
                                ),
                                Column(
                                  children: [
                                    LzForm.input(
                                      label: 'First Name',
                                      labelStyle:
                                          LzFormLabelStyle(color: color1),
                                      hint: 'first name',
                                      model: ref.watch(editProfilChangeNotifier).forms["first_name"],
                                    ),
                                    LzForm.input(
                                      label: 'Last Name',
                                      labelStyle:
                                          LzFormLabelStyle(color: color1),
                                      hint: 'last name',
                                      model: ref.watch(editProfilChangeNotifier).forms["last_name"],
                                    ),
                                    LzForm.input(
                                      label: 'profession',
                                      labelStyle:
                                          LzFormLabelStyle(color: color1),
                                      hint: 'profession',
                                      model: ref.watch(editProfilChangeNotifier).forms["profession"],
                                    ),
                                    LzForm.input(
                                      label: 'email',
                                      labelStyle:
                                          LzFormLabelStyle(color: color1),
                                      hint: 'email',
                                      model: ref.watch(editProfilChangeNotifier).forms["email"],
                                    ),
                                    LzForm.input(
                                      label: 'address',
                                      labelStyle:
                                          LzFormLabelStyle(color: color1),
                                      hint: 'address',
                                      maxLength: 100,
                                      model: ref.watch(editProfilChangeNotifier).forms["address"],
                                    ),
                                    LzForm.input(
                                      label: 'number phone',
                                      labelStyle:
                                          LzFormLabelStyle(color: color1),
                                      hint: 'number_phone',
                                      keyboard: const TextInputType.numberWithOptions(),
                                      maxLength: 13,
                                      model: ref.watch(editProfilChangeNotifier).forms["number_phone"],
                                    ),
                                    LzForm.input(
                                      label: 'earning',
                                      labelStyle:
                                          LzFormLabelStyle(color: color1),
                                      hint: 'earning',
                                      model: ref.watch(editProfilChangeNotifier).forms["earning"],
                                    ),
                                    LzForm.input(
                                      label: 'summary',
                                      labelStyle:
                                          LzFormLabelStyle(color: color1),
                                      hint: 'summary',
                                      maxLength: 2000,
                                      model: ref.watch(editProfilChangeNotifier).forms["summary"],
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
        ),
        bottomNavigationBar: LzButton(
          radius: 20,
          color: color1,
          textColor: Colors.white,
          text: 'Update',
          onTap: (state) async {
            final notifier = ref.read(editProfilChangeNotifier.notifier);
            notifier.edit(context, data!.id!);
          },
        ).theme1().margin(b: 10));
  }
}

class DecimalFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newString = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    final parts = newString.split('.');
    final integerPart = parts[0];
    
    return TextEditingValue(
      text: integerPart,
      selection: newValue.selection,
    );
  }
}