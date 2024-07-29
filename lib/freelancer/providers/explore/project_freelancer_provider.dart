import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class ProjectFreelancerProvider
    extends StateNotifier<AsyncValue<List<ProjectFreelancerModel>>>
    with UseApi {
  ProjectFreelancerProvider() : super(const AsyncValue.loading()) {
    getProjectFreelancer();
  }

  Future<void> getProjectFreelancer() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectFreelancerApi.getProjectFreelancer();

      if (res.status) {
        List data = res.data;
        state = AsyncValue.data(
            data.map((e) => ProjectFreelancerModel.fromJson(e)).toList());
      } else {
        state = AsyncValue.error(
            res.message ?? 'Unknown error', StackTrace.current);
        LzToast.show(res.message ?? 'Unknown error');
      }
    } catch (e, s) {
      state = AsyncValue.error(e.toString(), s);
      Errors.check(e, s);
    }
  }
}

final projectFreelancer = StateNotifierProvider.autoDispose<
    ProjectFreelancerProvider, AsyncValue<List<ProjectFreelancerModel>>>((ref) {
  return ProjectFreelancerProvider();
});
