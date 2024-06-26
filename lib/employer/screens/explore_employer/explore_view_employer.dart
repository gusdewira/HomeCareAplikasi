import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:homecare_app/employer/providers/project_provider.dart';
import 'package:homecare_app/employer/screens/explore_employer/widget/category.dart';
import 'package:homecare_app/employer/screens/explore_employer/widget/data.dart';
import 'package:homecare_app/employer/screens/explore_employer/widget/search_freelancer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../freelancer/widgets/color_widget.dart';

class ExploreView extends ConsumerStatefulWidget {
   const ExploreView({super.key});

  @override
  ConsumerState<ExploreView> createState() => ExploreEmployerView();
}

class ExploreEmployerView extends ConsumerState<ExploreView> {
  ExploreEmployerView();
  final TextEditingController _searchQuery = TextEditingController(text: '');
  String fromSalary = '';
  String toSalary = '';
  String location = '';
  final List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    var project = ref.watch(projectProvider);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            color3,
            color4,
          ],
          stops: const [0.0, 0.6],
        ),
      ),
      child: LzListView(
        padding: Ei.zero,
        children: [
          Stack(
            children: [
              Container(
                margin: Ei.only(t: 190),
                width: context.width,
                height: context.height,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: project.when(
                        data:
                            (List<ProjectEmployerModel> projectEmployeers) {
                          final projectEmployee =
                              projectEmployeers.where((project) {
                            return project.title!.toLowerCase().contains(
                                    _searchQuery.text.toLowerCase()) ||
                                project.description!
                                    .toLowerCase()
                                    .contains(_searchQuery.text.toLowerCase());
                          }).toList();
                          return projectEmployee.isNotEmpty
                              ? ListView.builder(
                                  itemCount: projectEmployee.length,
                                  itemBuilder: (context, index) {
                                    final projectEmployeer =
                                        projectEmployee[index];
                                    return DataExploreFreelancer(
                                      projectEmployee: projectEmployeer,
                                    );
                                  },
                                )
                              : const LzNoData(
                                  message: 'There is no data yet',
                                );
                        },
                        error: (error, _) {
                          ref
                              .read(projectProvider.notifier)
                              .getProject();
                          return LzNoData(message: 'Oops! $error');
                        },
                        loading: () => LzLoader.bar(message: 'Loading...'),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 25,
                child: Textr(
                  'Explore Project',
                  style: Gfont.bold.white.fsize(25),
                ),
              ),
              Positioned(
                top: 140,
                left: 15,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              margin: Ei.only(t: 80, l: 35, r: 35, b: 110),
                              padding: Ei.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white),
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
                                              style: Gfont.color(
                                                      LzColors.hex('000000'))
                                                  .fsize(15)
                                                  .bold,
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
                                        // mainAxisSize: Mas.min,
                                        // crossAxisAlignment: Caa.start,
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
                                                  labelStyle: LzFormLabelStyle(
                                                      color: color1),
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
                                                  labelStyle: LzFormLabelStyle(
                                                      color: color1),
                                                  hint: 'Salary Range',
                                                ).margin(t: 10),
                                              )),
                                            ],
                                          ),
                                          LzForm.checkbox(
                                            labelStyle:
                                                LzFormLabelStyle(color: color1),
                                            activeColor: color1,
                                            label: 'Category',
                                            options: [
                                              Option(
                                                  option: 'Mobile Development',
                                                  value: 'Mobile Development'),
                                              Option(
                                                  option: 'Content Writing',
                                                  value: 'Content Writing'),
                                              Option(
                                                  option: 'Digital Marketing',
                                                  value: 'Digital Marketing'),
                                              Option(
                                                  option: 'Video Editing',
                                                  value: 'Video Editing'),
                                              Option(
                                                  option: 'UI/UX Design',
                                                  value: 'UI/UX Design'),
                                              Option(
                                                  option: 'Game Development',
                                                  value: 'Game Development'),
                                              Option(
                                                  option: 'Data Entry',
                                                  value: 'Data Entry'),
                                              Option(
                                                  option: 'Virtual Assistance',
                                                  value: 'Virtual Assistance'),
                                            ],
                                            onChange: (selectedOptions) {
                                              final value =
                                                  selectedOptions.value;
                                              final dataExist =
                                                  selectedCategories
                                                      .contains(value);
                                              if (!dataExist) {
                                                selectedCategories.add(value);
                                              } else {
                                                selectedCategories
                                                    .remove(value);
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
                                            labelStyle:
                                                LzFormLabelStyle(color: color1),
                                            hint: 'Input Location',
                                          ).margin(b: 10),
                                          InkTouch(
                                            onTap: () {
                                              final query = {
                                                'start_salary': fromSalary,
                                                'end_salary': toSalary,
                                                'name_category': selectedCategories
                                                    .join(','),
                                                'location': location,
                                              };

print(query);
                                              ref
                                                  .read(projectProvider
                                                      .notifier)
                                                  .getProjectEmployerQuery(
                                                      query);
                                            },
                                            child: Container(
                                              height: 50,
                                              width: context.width,
                                              decoration: BoxDecoration(
                                                  color: color1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
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
                          },
                        );
                      },
                      icon: const Icon(
                        Ti.sortDescending,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Textr(
                      'Filter',
                      style: Gfont.white.fsize(15),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 100,
                left: 25,
                right: 25,
                child: Container(
                  height: 40,
                  width: 480,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: Row(
                    children: [
                      Iconr(
                        Ti.search,
                        alignment: Alignment.centerLeft,
                        margin: Ei.only(l: 20),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (query) async {
                            project = ref.watch(projectProvider);
                          },
                          controller: _searchQuery,
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ).margin(l: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
