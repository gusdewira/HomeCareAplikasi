import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class ProjectProvider
    extends StateNotifier<AsyncValue<List<ProjectFreelancerModel>>>
    with UseApi {
  ProjectProvider() : super(const AsyncValue.loading()) {
    getProjectFreelancer();
  }

  Future<void> getProjectFreelancer() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectFreelancerApi.getProjectFreelancer();

      if (res.status) {
        List data = res.data;
        if (mounted) {
          state = AsyncValue.data(
              data.map((e) => ProjectFreelancerModel.fromJson(e)).toList());
        }
      } else {
        if (mounted) {
          state = AsyncValue.error(res.message ?? 'Unknown error', StackTrace.current);
          LzToast.show(res.message ?? 'Unknown error');
        }
      }
    } catch (e, s) {
      if (mounted) {
        state = AsyncValue.error(e.toString(), s);
      }
      Errors.check(e, s);
    }
  }
}

final projectFreelancer = StateNotifierProvider.autoDispose<ProjectProvider,
    AsyncValue<List<ProjectFreelancerModel>>>((ref) {
  return ProjectProvider();
});