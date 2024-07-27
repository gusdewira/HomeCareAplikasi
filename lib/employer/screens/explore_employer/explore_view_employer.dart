import 'package:flutter/material.dart';
import 'package:homecare_app/employer/providers/freelancer_provider.dart';
import 'package:homecare_app/employer/screens/explore_employer/widget/data.dart';
import 'package:homecare_app/freelancer/data/models/setting/profile_freelancer_model.dart';
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
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _refreshProfiles();
  }

  void _refreshProfiles() {
    ref.watch(freelancerProvider.notifier).getFreelancer(
      query: {
        'start_salary': fromSalary,
        'end_salary': toSalary,
        'name_category': selectedCategories.join(','),
        'location': location,
        'search': _searchQuery.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var profiles = ref.watch(freelancerProvider);
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
                      child: profiles.when(
                        data: (List<ProfileFreelancerModel> profile) {
                          final projectEmployee = profile.where((freelancer) {
                            return "${freelancer.firstName} ${freelancer.lastName}"
                                    .toLowerCase()
                                    .contains(_searchQuery.text.toLowerCase()) ||
                                (freelancer.summary?.toLowerCase().contains(
                                        _searchQuery.text.toLowerCase()) ??
                                    false);
                          }).toList();
                          return projectEmployee.isNotEmpty
                              ? ListView.builder(
                                  itemCount: projectEmployee.length,
                                  itemBuilder: (context, index) {
                                    final projectEmployeer =
                                        projectEmployee[index];
                                    return DataExploreFreelancer(projectEmployee: projectEmployeer);
                                  },
                                )
                              : const LzNoData(
                                  message: 'There is no data yet',
                                );
                        },
                        error: (error, _) {
                          ref
                              .read(freelancerProvider.notifier)
                              .getFreelancer();
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
                  'Explore Freelancer',
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
                                                _refreshProfiles();
                                              },
                                              icon: const Icon(Ti.x))
                                        ],
                                      ),
                                      Column(
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
                                                    _refreshProfiles();
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
                                                    _refreshProfiles();
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
                                              const Option(
                                                  option: 'Mobile Development',
                                                  value: 'Mobile Development'),
                                              const Option(
                                                  option: 'Content Writing',
                                                  value: 'Content Writing'),
                                              const Option(
                                                  option: 'Digital Marketing',
                                                  value: 'Digital Marketing'),
                                              const Option(
                                                  option: 'Video Editing',
                                                  value: 'Video Editing'),
                                              const Option(
                                                  option: 'UI/UX Design',
                                                  value: 'UI/UX Design'),
                                              const Option(
                                                  option: 'Game Development',
                                                  value: 'Game Development'),
                                              const Option(
                                                  option: 'Data Entry',
                                                  value: 'Data Entry'),
                                              const Option(
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
                                              _refreshProfiles();
                                            },
                                          ),
                                          LzForm.input(
                                            label: 'Location',
                                            onChange: (value) {
                                              setState(() {
                                                location = value;
                                              });
                                              _refreshProfiles();
                                            },
                                            labelStyle:
                                                LzFormLabelStyle(color: color1),
                                            hint: 'Input Location',
                                          ).margin(b: 10),
                                          InkTouch(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              _refreshProfiles();
                                              print({
        'start_salary': fromSalary,
        'end_salary': toSalary,
        'name_category': selectedCategories.join(','),
        'location': location,
        'search': _searchQuery.text,
      },);
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
                          onChanged: (query) {
                            _refreshProfiles();
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