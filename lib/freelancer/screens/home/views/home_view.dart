import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/freelancer/data/models/setting/project_freelancer_model.dart';
import 'package:homecare_app/freelancer/providers/project/project_active_provider.dart';
import 'package:homecare_app/freelancer/providers/project/project_complated_provider.dart';
import 'package:homecare_app/freelancer/providers/project/project_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/profile_freelancer_model.dart';
import '../../../providers/setting/profile_provider.dart';
import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';
import '../widgets/all_project_home.dart';
import '../widgets/your_project_home.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  Future<void> _refreshData(WidgetRef ref) async {
    print('Refreshing data...');
    ref.refresh(profileFreelancerProvider);
    ref.refresh(projectFreelancer);
    ref.refresh(projectProgress);
    ref.refresh(projectComplated);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileFreelancerProvider);
    final projectActive = ref.watch(projectProgress);
    final projectCompleted = ref.watch(projectComplated);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [color3, color4],
          stops: const [0.1, 0.7],
        ),
      ),
      child: profileData.when(
        data: (ProfileFreelancerModel profile) {
          if (profile.id == null) {
            return const LzNoData(
              message: 'There is no data yet, please add data in the add experience menu',
            );
          }
          String email = profile.email ?? '';
          String firstName = profile.firstName ?? '';
          String lastName = profile.lastName ?? '';
          String earn = profile.earning != null ? profile.earning!.split('.')[0] : '';
          int? profileId = profile.id;

          if (profileId == null) {
            return const LzNoData(message: 'Profile ID is missing');
          }

          final projectData = ref.watch(projectFreelancer);

          return RefreshIndicator(
            onRefresh: () => _refreshData(ref),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 60,
                    left: 25,
                    child: InkTouch(
                      onTap: () {
                        context.push(Paths.profileHome);
                      },
                      child: Row(
                        children: [
                          profile.photoProfile != null &&
                                  profile.photoProfile is String
                              ? LzImage(
                                  profile.photoProfile!,
                                  radius: 50,
                                  size: 50,
                                )
                              : const Icon(
                                  Icons.account_circle,
                                  size: 50,
                                  color: Colors.white,
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Textr(
                                '$firstName $lastName',
                                width: 200,
                                maxLines: 1,
                                overflow: Tof.clip,
                                style: Gfont.bold.white,
                              ),
                              Textr(
                                email,
                                width: 200,
                                maxLines: 1,
                                overflow: Tof.clip,
                                style: Gfont.white.fsize(12),
                              ),
                            ],
                          ).margin(l: 15),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 25,
                    child: IconButton(
                      onPressed: () {
                        context.push(Paths.notificationHome);
                      },
                      icon: const Icon(
                        Ti.bell,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: Ei.only(t: 160),
                    width: context.width,
                    height: context.height,
                    decoration: BoxDecoration(
                      color: color2,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: Maa.start,
                    children: [
                      projectData.when(
                        data: (List<ProjectFreelancerModel> projects) {
                          print('Projects data loaded successfully');
                          late List<ProjectFreelancerModel> project =
                              projects.take(2).toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              YourProjectHome(projects: project),
                              projectActive.when(
                                data: (List<ProjectFreelancerModel> active) {
                                  return projectCompleted.when(
                                    data: (List<ProjectFreelancerModel> completed) {
                                      return AllProjectHome(
                                        projects: projects.length,
                                        active: active.length,
                                        completed: completed.length,
                                        rejected: 0,
                                      );
                                    },
                                    error: (error, stackTrace) {
                                      print('Error loading completed projects: $error');
                                      return LzNoData(
                                        message: 'Oops! $error',
                                      );
                                    },
                                    loading: () {
                                      print('Loading completed projects...');
                                      return LzLoader.bar(
                                        message: 'Loading1...',
                                      );
                                    },
                                  );
                                },
                                error: (error, stackTrace) {
                                  print('Error loading active projects: $error');
                                  return LzNoData(
                                    message: 'Oops! $error',
                                  );
                                },
                                loading: () {
                                  print('Loading active projects...');
                                  return LzLoader.bar(
                                    message: 'Loading2...',
                                  );
                                },
                              ),
                            ],
                          );
                        },
                        error: (error, stackTrace) {
                          print('Error loading projects data: $error');
                          return LzNoData(
                            message: 'Oops! $error',
                          );
                        },
                        loading: () {
                          print('Loading projects data...');
                          return LzLoader.bar(
                            message: 'Loading3...',
                          );
                        },
                      ),
                    ],
                  ).margin(l: 25, r: 25, t: 130),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          print('Error loading profile data: $error');
          return LzNoData(message: 'Oops! $error');
        },
        loading: () {
          print('Loading profile data...');
          return LzLoader.bar(message: 'Loading4...');
        },
      ),
    );
  }
}