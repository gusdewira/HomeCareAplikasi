import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../freelancer/widgets/color_widget.dart';

class CategoryFreelancer extends StatelessWidget {
  const CategoryFreelancer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Ei.only(t: 80, l: 35, r: 35, b: 110),
      padding: Ei.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
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
              Row(
                mainAxisAlignment: Maa.spaceBetween,
                children: [
                  Expanded(
                    child: Textr(
                      'Filter search project',
                      alignment: Alignment.center,
                      margin: Ei.only(l: 35),
                      style: Gfont.color(LzColors.hex('000000')).fsize(15).bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Ti.x))
                ],
              ),
              Column(
                mainAxisSize: Mas.min,
                crossAxisAlignment: Caa.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: Ei.only(r: 10),
                        child: LzForm.input(
                          label: 'From',
                          labelStyle: LzFormLabelStyle(color: color1),
                          hint: 'Salary Range',
                        ).margin(t: 10),
                      )),
                      Expanded(
                          child: Padding(
                        padding: Ei.only(l: 10),
                        child: LzForm.input(
                          label: 'To',
                          labelStyle: LzFormLabelStyle(color: color1),
                          hint: 'Salary Range',
                        ).margin(t: 10),
                      )),
                    ],
                  ),
                  LzForm.checkbox(
                    labelStyle: LzFormLabelStyle(color: color1),
                    activeColor: color1,
                    label: 'Category',
                    options: List.generate(
                        8,
                        (i) => Option(
                              option: [
                                'Mobile Development',
                                'Content Writing',
                                'Digital Marketing',
                                'Video Editing',
                                'UI/UX Design',
                                'Game Development',
                                'Data Entry',
                                'Virtual Assistance'
                              ][i],
                            )),
                  ),
                  LzForm.input(
                    label: 'Location',
                    labelStyle: LzFormLabelStyle(color: color1),
                    hint: 'Input Location',
                  ).margin(b: 10),
                  InkTouch(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: context.width,
                      decoration: BoxDecoration(
                          color: color1,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          'Search',
                          style: Gfont.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}