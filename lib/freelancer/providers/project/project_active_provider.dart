import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class ProjectProgressProvider
    extends StateNotifier<AsyncValue<List<ProjectFreelancerModel>>>
    with UseApi {
  ProjectProgressProvider() : super(const AsyncValue.loading()) {
    getProjectProgress();
  }

  Future<void> getProjectProgress() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectProgressApi.getProjectProgress();

      if (res.status) {
        if (!mounted) return;
        List<dynamic> data = res.data as List<dynamic>;
        state = AsyncValue.data(
            data.map((e) => ProjectFreelancerModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      if (mounted) {
        Errors.check(e, s);
      }
    }
  }
}

final projectProgress = StateNotifierProvider.autoDispose<
    ProjectProgressProvider, AsyncValue<List<ProjectFreelancerModel>>>((ref) {
  return ProjectProgressProvider();
});
