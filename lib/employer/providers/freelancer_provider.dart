import 'dart:core';

import 'package:fetchly/fetchly.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/freelancer/data/models/setting/profile_freelancer_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod/riverpod.dart';

class FreelancerProvider extends StateNotifier<AsyncValue<List<FreelancerExplore>>> with UseApi1 {
  FreelancerProvider() : super(const AsyncValue.loading()) {
    getFreelancer();
  }

  Future<void> getFreelancer() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await dashboardApi.getFreelancer();

      if (res.status) {
        List<FreelancerExplore> data = (res.data as List<dynamic>)
            .map((e) => FreelancerExplore.fromJson(e))
            .toList();
        state = AsyncValue.data(data);
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      print("Error: $e");
      Errors.check(e, s);
    }
  }
}

final freelancerProvider = StateNotifierProvider.autoDispose<FreelancerProvider, AsyncValue<List<FreelancerExplore>>>((ref) {
  return FreelancerProvider();
});