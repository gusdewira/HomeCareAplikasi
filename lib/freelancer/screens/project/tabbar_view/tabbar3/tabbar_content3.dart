import 'package:flutter/material.dart';
import 'package:homecare_app/freelancer/screens/explore/content_widget/detail_project_explore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
// Pastikan Anda menambahkan ini untuk DateFormat

import '../../../../data/models/setting/project_freelancer_model.dart';
import '../../../../providers/project/project_complated_provider.dart';
import '../../../../widgets/color_widget.dart';

class Tabbar3 extends ConsumerWidget {
  const Tabbar3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectFinished = ref.watch(projectComplated);

    Future<void> refreshProjects() async {
      await ref.refresh(projectComplated.notifier).getProjectComplated();
    }

    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    int convertRatingToStars(String ratingText) {
      switch (ratingText.toUpperCase()) {
        case 'BAD':
          return 1;
        case 'AVERAGE':
          return 2;
        case 'GOOD':
          return 3;
        case 'VERY_GOOD':
          return 4;
        case 'EXCELLENT':
          return 5;
        default:
          return 0;
      }
    }

    return Column(
      children: [
        Expanded(
          child: projectFinished.when(
            data: (List<ProjectFreelancerModel> projectComplateds) {
              return projectComplateds.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: refreshProjects,
                      child: ListView.builder(
                        itemCount: projectComplateds.length,
                        itemBuilder: (context, index) {
                          final projectComplated = projectComplateds[index];
                          String title = projectComplated.title!;
                          String firstName =
                              projectComplated.offer![0]['user']['first_name'];
                          String lastName =
                              projectComplated.offer![0]['user']['last_name'];
                          String startSalary =
                              formatNumber(projectComplated.startSalary ?? 0.0);
                          String endSalary =
                              formatNumber(projectComplated.endSalary ?? 0.0);
                          DateTime startDate = projectComplated.startDate!;
                          DateTime endDate = projectComplated.endDate!;
                          int rating = projectComplated.review!.isEmpty
                              ? 0
                              : convertRatingToStars(
                                  projectComplated.review![0]['quantity_star']);
                          // String address = projectComplated.user!['address'];
                          // int id = projectComplated.id!;

                          return InkTouch(
                            onTap: () {
                              context.lzPush(
                                  DetailProjectExplore(data: projectComplated));
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10),
                              margin: const EdgeInsets.only(
                                  left: 25, right: 25, bottom: 20, top: 20),
                              height: 180,
                              width: MediaQuery.of(context).size.width / 1,
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
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: Gfont.color(LzColors.hex('001380')),
                                  ),
                                  Text(
                                    'Freelancer: $firstName $lastName',
                                    style: Gfont.color(LzColors.hex('001380')),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text('Salary'),
                                            Text(
                                              maxLines: 1,
                                              overflow: Tof.ellipsis,
                                              '${startSalary!} - ${endSalary!}',
                                              style: Gfont.color(
                                                  LzColors.hex('001380')),
                                            ),
                                          ],
                                        ).margin(r: 5),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Estimated duration',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "$startDate - $endDate",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Gfont.color(
                                                  LzColors.hex('001380')),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ).margin(t: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(rating.toString()),
                                      Icon(
                                        Icons.star,
                                        color: rating >= 1
                                            ? LzColors.hex('FFD700')
                                            : Colors.grey,
                                        size: 20,
                                      ),
                                    ],
                                  ).margin(t: 10)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: refreshProjects,
                      child: const LzNoData(
                        message: 'No projects have been completed yet',
                      ));
            },
            error: (error, _) {
              ref.read(projectComplated.notifier).getProjectComplated();
              return LzNoData(message: 'Oops! $error');
            },
            loading: () {
              return LzLoader.bar(message: 'Loading...');
            },
          ),
        ),
      ],
    );
  }
}
