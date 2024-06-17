import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class ProjectProvider
    extends StateNotifier<AsyncValue<List<ProjectFreelancerModel>>>
    with UseApi {
  final int freelancerId;
  ProjectProvider(this.freelancerId) : super(const AsyncValue.loading()) {
    getProjectFreelancer();
  }

  Future<void> getProjectFreelancer() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectFreelancerApi
          .getProjectFreelancerByProfile(freelancerId);

      if (res.status) {
        dynamic data = res.data;
        if (data is List) {
          state = AsyncValue.data(data.map((e) => ProjectFreelancerModel.fromJson(e)).toList());
        } else {
          LzToast.show("Unexpected data type received");
        }
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final projectFreelancerByProfile = StateNotifierProvider.autoDispose
    .family<ProjectProvider, AsyncValue<List<ProjectFreelancerModel>>, int>(
        (ref, freelancerId) {
  return ProjectProvider(freelancerId);
});
