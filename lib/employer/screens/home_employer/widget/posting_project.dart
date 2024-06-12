import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

class PostingProjectEmployer extends StatelessWidget {
  const PostingProjectEmployer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  width: context.width,
                  height: context.height,
                  decoration: BoxDecoration(
                      color: color2,
                      ),
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
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: Center(
                        child: Textr(
                      'Posting Project',
                      style: Gfont.black.bold.fsize(18),
                    ))),
                Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        LzForm.input(
                          label: 'Project Title',
                          labelStyle: LzFormLabelStyle(color: color1),
                          hint: 'Project Title',
                        ),
                        LzForm.input(
                          label: 'Project Description',
                          labelStyle: LzFormLabelStyle(color: color1),
                          hint: 'Project Description',
                        ),
                        LzForm.input(
                          label: 'Category',
                          labelStyle: LzFormLabelStyle(color: color1),
                          hint: 'Project Category',
                          maxLength: 100,
                        ),
                        LzForm.input(
                          label: 'Attachment',
                          labelStyle: LzFormLabelStyle(color: color1),
                          hint: 'Attachment',
                          keyboard: const TextInputType.numberWithOptions(),
                          maxLength: 13,
                        ),
                        LzForm.input(
                          label: 'Skills Required',
                          labelStyle: LzFormLabelStyle(color: color1),
                          hint: 'Skills',
                          maxLength: 2000,
                        ),
                         LzForm.input(
                          label: 'Project Location',
                          labelStyle: LzFormLabelStyle(color: color1),
                          hint: 'Location',
                          maxLength: 2000,
                        ),
                      ],
                    ).margin(t: 10, l: 25, r: 25, b: 50)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
