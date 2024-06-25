import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/freelancer/data/models/setting/project_freelancer_model.dart';
import 'package:homecare_app/freelancer/providers/explore/project_freelancer_provider.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:homecare_app/freelancer/screens/explore/content_widget/bid_explore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';
import '../content_widget/data_explore.dart';
import '../widgets/dialog_category.dart';
import '../widgets/search_widget_explore.dart';

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({super.key});

  @override
  ConsumerState<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  _ExploreViewState();
  final TextEditingController _searchQuery = TextEditingController(text: '');
  String fromSalary = '';
  String toSalary = '';
  String location = '';
  final List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    var project = ref.watch(projectFreelancer);
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
                            (List<ProjectFreelancerModel> projectFreelancers) {
                          final projectFreelance =
                              projectFreelancers.where((project) {
                            return project.title!.toLowerCase().contains(
                                    _searchQuery.text.toLowerCase()) ||
                                project.description!
                                    .toLowerCase()
                                    .contains(_searchQuery.text.toLowerCase());
                          }).toList();
                          return projectFreelance.isNotEmpty
                              ? ListView.builder(
                                  itemCount: projectFreelance.length,
                                  itemBuilder: (context, index) {
                                    final projectFreelancer =
                                        projectFreelance[index];
                                    return ProjectFreelancerCard(
                                      projectFreelancer: projectFreelancer,
                                    );
                                  },
                                )
                              : const LzNoData(
                                  message: 'There is no data yet',
                                );
                        },
                        error: (error, _) {
                          ref
                              .read(projectFreelancer.notifier)
                              .getProjectFreelancer();
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
                                                  .read(projectFreelancer
                                                      .notifier)
                                                  .getProjectFreelancerQuery(
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
                            project = ref.watch(projectFreelancer);
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

class ProjectFreelancerCard extends StatelessWidget {
  final ProjectFreelancerModel projectFreelancer;

  const ProjectFreelancerCard({Key? key, required this.projectFreelancer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = projectFreelancer.title ?? '';
    final description = projectFreelancer.description ?? '';
    final startSalary = projectFreelancer.startSalary ?? 0.0;
    final endSalary = projectFreelancer.endSalary ?? 0.0;
    final startDate = projectFreelancer.startDate ?? DateTime.now();
    final endDate = projectFreelancer.endDate ?? DateTime.now();
    final id = projectFreelancer.id ?? 0;

    return Container(
      padding: Ei.only(l: 20, r: 20, t: 10),
      margin: Ei.only(l: 25, r: 25, b: 20),
      height: 250,
      width: context.width / 1,
      decoration: BoxDecoration(
        color: LzColors.hex('FFFFFF'),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: Mas.min,
        crossAxisAlignment: Caa.start,
        children: [
          SizedBox(
            width: context.width,
            height: 20,
            child: Row(
              mainAxisSize: Mas.min,
              mainAxisAlignment: Maa.spaceBetween,
              children: [
                Expanded(
                  child: Textr(
                    title,
                    style: Gfont.color(color1).bold.fsize(16),
                    margin: Ei.only(r: 30),
                    width: context.width,
                    maxLines: 1,
                    overflow: Tof.ellipsis,
                  ),
                ),
                InkTouch(
                  onTap: () {
                    context.push('${Paths.detailProjectexplore}/$id');
                  },
                  child: Icon(
                    Ti.infoCircle,
                    size: 25,
                    color: LzColors.hex('0047E3'),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'posted 1 hours ago',
            style: Gfont.color(LzColors.hex('747474')).fsize(12),
          ).margin(t: 5, b: 5),
          SizedBox(
            width: context.width,
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Ti.coin,
                      color: Colors.green,
                    ).margin(r: 5),
                    Textr(
                      '$startSalary - $endSalary',
                      style: Gfont.color(black).fsize(12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Ti.clock,
                      color: Colors.red,
                    ).margin(r: 5),
                    Textr(
                      '${DateFormat('dd/MM/yyyy').format(startDate)} - ${DateFormat('dd/MM/yyyy').format(endDate)}',
                      style: Gfont.color(black).fsize(12),
                      width: context.width / 3 + 10,
                      maxLines: 1,
                      overflow: Tof.ellipsis,
                    ),
                  ],
                ).margin(t: 5),
                Row(
                  children: [
                    Icon(
                      Ti.mapPin,
                      color: color1,
                    ).margin(r: 5),
                    Textr(
                      'Galkasoft',
                      style: Gfont.color(black).fsize(12),
                      width: context.width / 3,
                      maxLines: 1,
                      overflow: Tof.ellipsis,
                    ),
                  ],
                ).margin(t: 5),
              ],
            ),
          ),
          Textr(
            description,
            style: Gfont.color(black).fsize(12),
            margin: Ei.only(t: 10),
            maxLines: 3,
            overflow: Tof.ellipsis,
          ),
          Flexible(
            child: InkTouch(
              onTap: () {
                context.lzPush(BidExplore(data: projectFreelancer));
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: Ei.only(t: 10, b: 20),
                  height: 30,
                  width: context.width,
                  decoration: BoxDecoration(
                    color: color1,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Bid Project',
                      style: Gfont.white.bold.fsize(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
