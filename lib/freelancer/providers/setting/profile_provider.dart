import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/api/api.dart';
import '../../data/models/setting/profile_freelancer_model.dart';

class ProfileFreelancerProvider extends StateNotifier<AsyncValue<ProfileFreelancerModel>> with UseApi {
  ProfileFreelancerProvider() : super(const AsyncValue.loading()) {
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      state = const AsyncValue.loading();
      ResHandler res = await profileFreelancerApi.getProfileFreelancer();
      
      if (res.status) {
        state = AsyncValue.data(ProfileFreelancerModel.fromJson(res.data ?? {}));
      } else {
        LzToast.show(res.message);
        state = AsyncValue.error(res.message ?? 'Unknown error occurred', StackTrace.current);

      }
    } catch (e, s) {
      print('Error: $e');
      Errors.check(e, s);
      state = AsyncValue.error(e, s);
    }
  }
}

final profileFreelancerProvider = StateNotifierProvider<ProfileFreelancerProvider, AsyncValue<ProfileFreelancerModel>>((ref) {
  return ProfileFreelancerProvider();
});
