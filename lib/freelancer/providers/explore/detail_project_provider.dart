import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class ProjectFreelancerProvider
    extends StateNotifier<AsyncValue<ProjectFreelancerModel>> with UseApi {
  ProjectFreelancerProvider() : super(const AsyncValue.loading()) {
    getProjectFreelancer();
    }

  Future<void> getProjectFreelancer() async {
  try {
    state = const AsyncValue.loading();

    ResHandler res = await projectFreelancerApi.getDetailProjectFreelancer(15);

    if (res.status) {
      state = AsyncValue.data(ProjectFreelancerModel.fromJson(res.data));
    } else {
      LzToast.show(res.message);
    }
  } catch (e, s) {
    Errors.check(e, s);
  }
}
    }

final detailProjectFreelancer = StateNotifierProvider.autoDispose<ProjectFreelancerProvider, AsyncValue<ProjectFreelancerModel>>((ref) {
  return ProjectFreelancerProvider();
});
