import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/data/models/profile_model.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:homecare_app/employer/providers/profile_provider.dart';
import 'package:homecare_app/employer/providers/project_completed_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';

class Tabbar3ProjectEmployer extends ConsumerWidget {
  const Tabbar3ProjectEmployer({super.key});

  Future<void> _refreshData(WidgetRef ref) async {
    final projectProvider = ref.read(projectCompletedProvider.notifier);
    await projectProvider.getDataProject();
  }

  void showEndContractDialog(
      BuildContext context, int userId, int projectId, int freelancerId) {
    int rating = 0;
    String description = '';
    Map<int, String> ratingCategories = {
      1: 'BAD',
      2: 'AVERAGE',
      3: 'GOOD',
      4: 'VERY_GOOD',
      5: 'EXCELLENT',
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  title: Row(
                    children: [
                      Textr(
                        margin: Ei.only(l: 50),
                        alignment: Alignment.center,
                        'Give Me The Rates',
                        style: Gfont.color(LzColors.hex('001380')).fsize(20),
                      ),
                      const Spacer(),
                      InkTouch(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Ti.x, color: Colors.black, size: 25),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              Icons.star,
                              color: index < rating
                                  ? LzColors.hex('FFD700')
                                  : Colors.grey,
                              size: 40,
                            ),
                            onPressed: () {
                              setState(() {
                                rating = index + 1;
                              });
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                      ),
                    ],
                  ),
                  actions: [
                    InkTouch(
                      onTap: () async {
                        Map<String, dynamic> data = {
                          "review_from_id": userId,
                          "quantity_star": rating,
                          "project_id": projectId,
                          "review_text": description,
                          "review_for_id": freelancerId
                        };
                        ResHandler res = await ReviewProject().postReview(data);
                        LzToast.dismiss();
                        if (!res.status) {
                          LzToast.show(res.message);
                          return false;
                        } else {
                          LzToast.show('Successfully add review project');
                          Navigator.pop(context);
                          return true;
                        }
                      },
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 20, right: 10, left: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: LzColors.hex('0047E3'),
                          ),
                          child: Textr(
                            alignment: Alignment.center,
                            'Send',
                            style: Gfont.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectCompleted = ref.watch(projectCompletedProvider);
    final profileEmployee = ref.watch(profileEmployeeProvider);

    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    return RefreshIndicator(
      onRefresh: () => _refreshData(ref),
      child: projectCompleted.when(
        data: (List<ProjectEmployerModel> projects) {
          if (projects.isEmpty) {
            return RefreshIndicator(
                onRefresh: () => _refreshData(ref),
                child: Center(
                  child: Text(
                    'No data available',
                    style: Gfont.color(LzColors.hex('001380')).fsize(16),
                  ),
                ));
          }
          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              ProjectEmployerModel project = projects[index];
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                      project.title!,
                      style: Gfont.color(LzColors.hex('001380')),
                    ),
                    Text(
                      'Freelancer: ${project.offer![0]["user"]["first_name"]} ${project.offer![0]["user"]["last_name"]}',
                      style: Gfont.color(LzColors.hex('001380')),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Salary'),
                              Text(
                                maxLines: 1,
                                overflow: Tof.ellipsis,
                                '${formatNumber(project.startSalary!)} - ${formatNumber(project.endSalary!)}',
                                style: Gfont.color(LzColors.hex('001380')),
                              ),
                            ],
                          ).margin(r: 5),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Estimated duration',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${project.startDate.format('dd/MM/yyyy')} - ${project.endDate.format('dd/MM/yyyy')}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Gfont.color(LzColors.hex('001380')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).margin(t: 10),
                    profileEmployee.when(
                      data: (ProfileEmployerModel profile) {
                        if (project.review != null &&
                            project.review!.isNotEmpty) {
                          bool hasReviewed = false;
                          int rating = 0;

                          for (var review in project.review!) {
                            if (review['review_from_id']['id'] == profile.id) {
                              rating =
                                  convertRatingToStars(review['quantity_star']);
                              hasReviewed = true;
                              break;
                            }
                          }

                          if (hasReviewed) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                ).margin(t: 20, r: 5),
                                InkTouch(
                                    onTap: () {},
                                    child: SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Textr(
                                              alignment: Alignment.center,
                                              'Message',
                                              style: Gfont.blue.fsize(12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).margin(t: 20))
                              ],
                            );
                          } else {
                            return InkTouch(
                              onTap: () {
                                showEndContractDialog(
                                  context,
                                  project.user!['id'],
                                  project.id!,
                                  project.offer![0]['offer_by'],
                                );
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.green),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Textr(
                                        alignment: Alignment.center,
                                        'Leave a review',
                                        style: Gfont.green.fsize(12),
                                      ),
                                    ),
                                  ],
                                ),
                              ).margin(t: 20),
                            );
                          }
                        } else {
                          return InkTouch(
                            onTap: () {
                              showEndContractDialog(
                                context,
                                project.user!['id'],
                                project.id!,
                                project.offer![0]['offer_by'],
                              );
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Textr(
                                      alignment: Alignment.center,
                                      'Leave a review',
                                      style: Gfont.green.fsize(12),
                                    ),
                                  ),
                                ],
                              ),
                            ).margin(t: 20),
                          );
                        }
                      },
                      error: (error, _) {
                        return LzNoData(message: 'Oops! $error');
                      },
                      loading: () {
                        return LzLoader.bar(message: 'Loading...');
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        error: (error, _) {
          return LzNoData(message: 'Oops! $error');
        },
        loading: () {
          return LzLoader.bar(message: 'Loading...');
        },
      ),
    );
  }
}
