import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import 'package:fetchly/fetchly.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class ProjectFreelancerProvider
    extends StateNotifier<AsyncValue<ProjectFreelancerModel>> with UseApi {
  ProjectFreelancerProvider(int id) : super(const AsyncValue.loading()) {
    getProjectFreelancer(id);
  }

  Future<void> getProjectFreelancer(int id) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectFreelancerApi.getDetailProjectFreelancer(id);

      if (res.status) {
        state = AsyncValue.data(ProjectFreelancerModel.fromJson(res.data));
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      Errors.check(e, s);
    }
  }
}

final detailProjectFreelancer = StateNotifierProvider.autoDispose
    .family<ProjectFreelancerProvider, AsyncValue<ProjectFreelancerModel>, int>(
  (ref, id) {
    return ProjectFreelancerProvider(id);
  },
);