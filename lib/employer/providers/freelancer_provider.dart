import 'dart:core';

import 'package:fetchly/fetchly.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/freelancer/data/models/setting/profile_freelancer_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod/riverpod.dart';

class FreelancerProvider extends StateNotifier<AsyncValue<List<ProfileFreelancerModel>>> with UseApi1 {
  FreelancerProvider() : super(const AsyncValue.loading()) {
    getFreelancer();
  }

  Future<void> getFreelancer({Map<String, dynamic>? query}) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await dashboardApi.getFreelancer(query ?? {});

      if (res.status) {
        List data = res.data;
        state = AsyncValue.data(
            data.map((e) => ProfileFreelancerModel.fromJson(e)).toList());
            } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      print("Error: $e");
      Errors.check(e, s);
    }
  }
}

final freelancerProvider = StateNotifierProvider.autoDispose<FreelancerProvider, AsyncValue<List<ProfileFreelancerModel>>>((ref) {
  return FreelancerProvider();
});
