import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/providers/auth_provider.dart' as logout1;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../../providers/login/login_provider.dart';
import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  String _selectedRole = 'Freelancer';
  final List<String> _roles = ['Freelancer', 'Employer'];

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(authProvider.notifier);
    final logout = ref.watch(logout1.authProvider.notifier);
    final forms = notifier.forms;

    return Scaffold(
      body: LzFormList(
        cleanOnFilled: true,
        style: LzFormStyle(
          activeColor: LzColors.black,
          inputBorderColor: Colors.black,
          type: FormType.topInner,
        ),
        padding: Ei.zero,
        children: [
          SizedBox(
            height: 135,
            width: context.width,
            child: const LzImage(
              'glombangAtas.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 475, // Sesuaikan tinggi container
            padding: Ei.only(l: 20, r: 20),
            child: Column(
              mainAxisSize: Mas.min,
              crossAxisAlignment: Caa.center,
              children: [
                Text(
                  'Login',
                  style: Gfont.bold.fsize(25),
                ),
                Text(
                  'Login using your account to continue.',
                  style: Gfont.color(LzColors.hex('747474')).fsize(12),
                ).margin(t: 10),
                InkTouch(
                  onTap: () {},
                  child: Container(
                    margin: Ei.only(t: 20),
                    height: 55,
                    width: context.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: Mas.min,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: LzImage('logoGoogle.png', size: 25),
                        ).margin(l: 15),
                        Expanded(
                          child: Center(
                            child: Text('Google', style: Gfont.bold.fsize(12))
                                .margin(r: 35),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                LzTextDivider(
                  Text(
                    'Or login with',
                    style: Gfont.color(LzColors.hex('6E7D83')).fsize(12),
                  ),
                ).margin(t: 10),
                LzForm.input(
                  label: 'Email',
                  hint: 'email@gmail.com',
                  model: forms['email'],
                ).margin(t: 20),
                LzForm.input(
                  label: 'Password',
                  hint: '********',
                  obsecureToggle: true,
                  model: forms['password'],
                ),
                InkWell(
                  onTap: () {
                    context.push(Paths.forgetpass);
                  },
                  child: Textr(
                    'Forgot Password?',
                    alignment: Alignment.centerRight,
                    style: Gfont.red.bold.fsize(12),
                  ),
                ),
                const Text(
                  "I am a: ",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                RadioGroup<String>.builder(
                  groupValue: _selectedRole,
                  horizontalAlignment: MainAxisAlignment.spaceAround,
                  direction: Axis.horizontal,
                  onChanged: (value) => setState(() {
                    _selectedRole = value!;
                  }),
                  items: _roles,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item,
                  ),
                ).margin(t: 20),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                margin: Ei.only(l: 25, r: 25),
                width: context.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final ok = await notifier.login(context, ref);
                    if (ok['status']) {
                      if (ok['role'] != _selectedRole.toLowerCase()) {
                        LzToast.show("You're not $_selectedRole");
                         await logout.logout();
                        return;
                      }

                      if (ok['role'] == "freelancer") {
                        context.go(Paths.home);
                        LzToast.show("Login success as Freelancer");
                      } else {
                        context.go(Paths.home2);
                        LzToast.show("Login success as Employer");
                      }
                    } else {
                      LzToast.show("Login Failed!");
                    }
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
                    'Login',
                    style: Gfont.bold.white.fsize(15),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: Maa.center,
                children: [
                  Textr(
                    'Don\'t have an account?',
                    style: Gfont.color(LzColors.hex('7E7E7E')).bold.fsize(12),
                  ),
                  InkWell(
                    onTap: () {
                      context.push(Paths.signup);
                    },
                    child: Text(
                      '  Sign Up',
                      style: Gfont.color(colorLogin).bold.fsize(15),
                    ),
                  ),
                ],
              ).margin(t: 70),
              Container(
                margin: Ei.only(t: 170),
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: const LzImage(
                  'glombang.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: LzImage(
                  'logoHomecare.png',
                  size: 100,
                ),
              ).margin(t: 120),
            ],
          )
        ],
      ),
    );
  }
}