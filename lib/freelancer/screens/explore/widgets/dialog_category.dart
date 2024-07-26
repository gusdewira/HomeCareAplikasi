import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';

class DialogCategory extends StatefulWidget {
  const DialogCategory({super.key});

  @override
  State<DialogCategory> createState() => _DialogCategoryState();
}

class _DialogCategoryState extends State<DialogCategory> {
  String fromSalary = '';
  String toSalary = '';
  String location = '';
  final List<String> selectedCategories = [];

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
                          onChange: (value) {
                            setState(() {
                              fromSalary = value;
                            });
                          },
                          labelStyle: LzFormLabelStyle(color: color1),
                          hint: 'Salary Range',
                        ).margin(t: 10),
                      )),
                      Expanded(
                          child: Padding(
                        padding: Ei.only(l: 10),
                        child: LzForm.input(
                          label: 'To',
                          onChange: (value) {
                            setState(() {
                              toSalary = value;
                            });
                          },
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
                    options: [
                      const Option(option: 'Mobile Development', value: 'Mobile Development'),
                      const Option(option: 'Content Writing', value: 'Content Writing'),
                      const Option(option: 'Digital Marketing', value: 'Digital Marketing'),
                      const Option(option: 'Video Editing', value: 'Video Editing'),
                      const Option(option: 'UI/UX Design', value: 'UI/UX Design'),
                      const Option(option: 'Game Development', value: 'Game Development'),
                      const Option(option: 'Data Entry', value: 'Data Entry'),
                      const Option(option: 'Virtual Assistance', value: 'Virtual Assistance'),
                    ],
                    onChange: (selectedOptions) {
                      final value = selectedOptions.value;
                      final dataExist = selectedCategories.contains(value);
                      if(!dataExist){
                        selectedCategories.add(value);
                      }else{
                        selectedCategories.remove(value);
                      }
                    },
                  ),
                  LzForm.input(
                    label: 'Location',
                    onChange: (value) {
                      setState(() {
                        location = value;
                      });
                    },
                    labelStyle: LzFormLabelStyle(color: color1),
                    hint: 'Input Location',
                  ).margin(b: 10),
                  InkTouch(
                    onTap: () {
                      print('Salary Range: $fromSalary - $toSalary');
                      print('Categories: $selectedCategories');
                      print('Location: $location');
                    },
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
