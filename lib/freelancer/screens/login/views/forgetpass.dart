import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazyui/lazyui.dart';

import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';

class ForgetPass extends StatelessWidget {
  const ForgetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return LzFormList(
      cleanOnFilled: true,
      style: LzFormStyle(
        activeColor: LzColors.black,
        inputBorderColor: Colors.black,
        type: FormType.topInner,
      ),
      padding: Ei.zero,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: Ei.only(t: 80),
              child: Column(
                mainAxisSize: Mas.min,
                children: [
                  Text(
                    'Enter Your Email',
                    style: Gfont.bold.fsize(20),
                  ).margin(b: 10),
                  const Text('Enter Email Address to get link'),
                  const Text('reset your password')
                ],
              ),
            ),
            Positioned(
                top: 70,
                left: 10,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Ti.chevronLeft,
                      size: 30,
                    )))
          ],
        ),
        LzForm.input(
          label: 'Email',
          hint: 'email@gmail.com',
        ).margin(t: 80, l: 25, r: 25),
        Container(
          margin: Ei.only(t: 230, l: 25, r: 25),
          width: context.width,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              context.push(Paths.forgetpassSendKode);
            },
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(colorLogin),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                )),
            child: Text(
              'Send',
              style: Gfont.bold.white.fsize(15),
            ),
          ),
        ),
        Container(
          margin: Ei.only(t: 100),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: const LzImage(
                'glombang.png',
                fit: BoxFit.cover,
              ),
            ),
      ],
    );
  }
}
