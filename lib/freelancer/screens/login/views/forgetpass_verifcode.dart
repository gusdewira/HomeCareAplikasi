import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';


class ForgetpassVerifCode extends StatelessWidget {
  const ForgetpassVerifCode({super.key});

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
                    'Forgot Password',
                    style: Gfont.bold.fsize(20),
                  ).margin(b: 10),
                  const Text('Don’t worry about your account'),
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
        Center(
          child: Column(
            children: [
              Text('Code was sent to your email', style: Gfont.color(LzColors.hex('595959')),),
              Text('email@gmail.com', style: Gfont.color(LzColors.hex('211992')),)
            ],
          ),
        ).margin(t: 80),
        Center(
          child: Text('This code will epired on 5 minutes',style: Gfont.color(LzColors.hex('595959')).fsize(15),)).margin(t: 70),
        Container(
          margin: Ei.only(t: 15, l: 25, r: 25),
          width: context.width,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
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
              'Verify Code',
              style: Gfont.bold.white.fsize(15),
            ),
          ),
        ),
        InkTouch(
          onTap: (){},
          child: Center(
            child: Text('Resend Kode',style: Gfont.color(colorLogin).bold.fsize(15),)).margin(t: 15),
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