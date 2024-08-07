import 'package:flutter/material.dart';
import 'package:homecare_app/freelancer/data/models/setting/project_freelancer_model.dart';
import 'package:homecare_app/freelancer/providers/explore/project_freelancer_provider.dart';
import 'package:homecare_app/freelancer/screens/explore/content_widget/bid_explore.dart';
import 'package:homecare_app/freelancer/screens/explore/content_widget/detail_project_explore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';

class ExploreView extends ConsumerStatefulWidget {
  const ExploreView({super.key});

  @override
  ConsumerState<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends ConsumerState<ExploreView> {
  _ExploreViewState();
  final TextEditingController _searchQuery = TextEditingController(text: '');
  int fromSalary = 0;
  int toSalary = 0;
  String location = '';
  String selectedCategory = '';

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
    _refreshProject();
  }

  Future<void> _refreshProject() async {
    await ref.watch(projectFreelancer.notifier).getProjectFreelancer();
  }

  Future<void> _refreshProject1() async {
    await ref.watch(projectFreelancer.notifier).getProjectFreelancer();
    fromSalary = 0;
    toSalary = 0;
    selectedCategory = '';
    location = '';
  }

  final List<Map<String, String>> salaryRanges = [
    {'start': '- Please Select Range', 'end': ''},
    {'start': '200.000', 'end': '350.000'},
    {'start': '350.000', 'end': '500.000'},
    {'start': '500.000', 'end': '1.000.000'},
    {'start': '1.000.000', 'end': '2.500.000'},
    {'start': '2.500.000', 'end': '4.000.000'},
    {'start': '4.000.000', 'end': '5.500.000'},
  ];

  final List<Map<String, String>> categoryOptions = [
    {'label': 'Digital Marketing', 'value': 'Digital Marketing'}
  ];

  @override
  Widget build(BuildContext context) {
    var project = ref.watch(projectFreelancer);
    return RefreshIndicator(
      onRefresh: _refreshProject1,
      child: Container(
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
                          final bool hasFilters = fromSalary > 0 ||
                              toSalary > 0 ||
                              selectedCategory.isNotEmpty ||
                              location.isNotEmpty ||
                              _searchQuery.text.isNotEmpty;

                          final projectFreelance = hasFilters
                              ? projectFreelancers.where((freelancer) {
                                  final startSalary =
                                      freelancer.startSalary ?? 0.0;
                                  final endSalary = freelancer.endSalary ?? 0.0;
                                  final profession =
                                      freelancer.user?['profession'] ?? '';
                                  final address =
                                      freelancer.user?['address'] ?? '';
                                  final summary = freelancer.description ?? '';
                                  final name = freelancer.title ?? '';

                                  final fromSalaryValue = fromSalary > 0
                                      ? fromSalary.toDouble()
                                      : null;
                                  final toSalaryValue =
                                      toSalary > 0 ? toSalary.toDouble() : null;

                                  final matchesSalary =
                                      (fromSalaryValue == null ||
                                              startSalary >= fromSalaryValue) &&
                                          (toSalaryValue == null ||
                                              endSalary <= toSalaryValue);
                                  final matchesCategory = profession.isEmpty ||
                                      profession.contains(selectedCategory);
                                  final matchesLocation = location.isEmpty ||
                                      address.contains(location);
                                  final matchesSearch = _searchQuery
                                          .text.isEmpty ||
                                      name.toLowerCase().contains(
                                          _searchQuery.text.toLowerCase()) ||
                                      summary.toLowerCase().contains(
                                          _searchQuery.text.toLowerCase());

                                  return matchesSalary &&
                                      matchesCategory &&
                                      matchesLocation &&
                                      matchesSearch;
                                }).toList()
                              : projectFreelancers;

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
                        loading: () => LzLoader.bar(message: 'Loading1...'),
                      )),
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
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Filter search project',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: const Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      DropdownButtonFormField<
                                          Map<String, String>>(
                                        decoration: InputDecoration(
                                          labelText: 'Salary Range',
                                          labelStyle: TextStyle(color: color1),
                                          hintText: 'Select Salary Range',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: color1,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 12),
                                        ),
                                        value: salaryRanges[0],
                                        onChanged:
                                            (Map<String, String>? newValue) {
                                          if (newValue!['end'] != null ||
                                              newValue['end'] == '') {
                                            fromSalary = int.tryParse(
                                                    newValue['start']!
                                                        .replaceAll('.', '')
                                                        .replaceAll(',', '')) ??
                                                0;
                                            toSalary = int.tryParse(
                                                    newValue['end']!
                                                        .replaceAll('.', '')
                                                        .replaceAll(',', '')) ??
                                                0;
                                            ;
                                          }
                                        },
                                        items: salaryRanges.map<
                                                DropdownMenuItem<
                                                    Map<String, String>>>(
                                            (Map<String, String> value) {
                                          return DropdownMenuItem<
                                              Map<String, String>>(
                                            value: value,
                                            child: Text(
                                                '${value['start']} - ${value['end']}'),
                                          );
                                        }).toList(),
                                      ),
                                      const SizedBox(height: 10),
                                      DropdownButtonFormField<String>(
                                        value: selectedCategory.isEmpty
                                            ? null
                                            : selectedCategory,
                                        decoration: const InputDecoration(
                                          labelText: 'Category',
                                        ),
                                        items: categoryOptions
                                            .map((dynamic value) {
                                          return DropdownMenuItem<String>(
                                            value: value['value'],
                                            child: Text(value['label']),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedCategory = newValue ?? '';
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: double.infinity,
                                        child: LzButton(
                                          radius: 20,
                                          color: color1,
                                          text: 'Save',
                                          textColor: Colors.white,
                                          onTap: (state) {
                                            Navigator.of(context).pop();
                                            _refreshProject();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}

class ProjectFreelancerCard extends StatelessWidget {
  final ProjectFreelancerModel projectFreelancer;

  const ProjectFreelancerCard({super.key, required this.projectFreelancer});

  @override
  Widget build(BuildContext context) {
    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    final title = projectFreelancer.title ?? '';
    final description = projectFreelancer.description ?? '';
    final startSalary = formatNumber(projectFreelancer.startSalary ?? 0.0);
    final endSalary = formatNumber(projectFreelancer.endSalary ?? 0.0);
    final startDate = projectFreelancer.startDate ?? DateTime.now();
    final endDate = projectFreelancer.endDate ?? DateTime.now();
    // final address = projectFreelancer.user?['address'] ?? 'No Address';

    return Container(
      padding: Ei.only(l: 20, r: 20, t: 10),
      margin: Ei.only(l: 25, r: 25, b: 20),
      height: 190,
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
                    context.lzPush(DetailProjectExplore(
                      data: projectFreelancer,
                    ));
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
          // Text(
          //   'posted 1 hours ago',
          //   style: Gfont.color(LzColors.hex('747474')).fsize(12),
          // ).margin(t: 5, b: 5),
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
                      width: context.width / 3 + 30,
                      maxLines: 1,
                      overflow: Tof.ellipsis,
                    ),
                  ],
                ).margin(t: 5),
              ],
            ),
          ).margin(t: 10),
          Textr(
            description,
            style: Gfont.color(black).fsize(12),
            margin: Ei.only(t: 10),
            maxLines: 2,
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
