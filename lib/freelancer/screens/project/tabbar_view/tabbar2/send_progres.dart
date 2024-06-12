import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../widgets/color_widget.dart';

class SendProgressProject extends StatelessWidget {
  const SendProgressProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              LzColors.hex('11B0E6'),
              LzColors.hex('3265FF'),
            ],
            stops: const [
              0.0,
              0.6
            ]),
      ),
      child: LzFormList(
        cleanOnFilled: true,
        style: LzFormStyle(
          activeColor: LzColors.dark,
          inputBorderColor: Colors.black26,
          type: FormType.topInner,
        ),
        padding: Ei.zero,
        children: [
          Stack(
            children: [
              Container(
                margin: Ei.only(t: 120),
                width: context.width,
                height: context.height,
                decoration: BoxDecoration(
                    color: LzColors.hex('F8F8FF'),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
              ),
              Positioned(
                top: 50,
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
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Center(
                      child: Textr(
                    'Send Progress Project',
                    style: Gfont.white.bold.fsize(18),
                  ))),
              Column(
                crossAxisAlignment: Caa.start,
                children: [
                  Textr(
                    'Mobile App Development',
                    margin: Ei.only(b: 10),
                    width: context.width / 2 + 20,
                    maxLines: 1,
                    style: Gfont.color(LzColors.hex('000000')).bold,
                  ),
                  SizedBox(
                    width: context.width,
                    child: Row(
                      mainAxisAlignment: Maa.spaceBetween,
                      children: [
                        Text(
                          'Start date : 23-12-2023',
                          style: Gfont.fs12.bold,
                        ),
                        Text(
                          'End date : 23-12-2023',
                          style: Gfont.fs12.bold,
                        )
                      ],
                    ).margin(b: 20),
                  ),
                  Container(
                    width: context.width,
                    height: 1,
                    color: Colors.black54,
                  ),
                  LzForm.input(
                    label: 'Title',
                    labelStyle: LzFormLabelStyle(color: color1),
                    hint: 'Input Title',
                  ).margin(t: 20),
                  LzForm.input(
                    label: 'attachment',
                    labelStyle: LzFormLabelStyle(color: color1),
                    hint: 'Upload attachment',
                    suffixIcon: La.upload,
                  ),
                  Container(
                    height: 40,
                    width: context.width,
                    margin: Ei.only(t: 20),
                    decoration: BoxDecoration(
                        color: LzColors.hex('0047E3'),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        'Send',
                        style: Gfont.white.fsize(15),
                      ),
                    ),
                  )
                ],
              ).margin(t: 140, l: 25, r: 25)
            ],
          ),
        ],
      ),
    );
  }
}
