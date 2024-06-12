import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/explore/project_freelancer_model.dart';

class ProjectFreelancerProvider
    extends StateNotifier<AsyncValue<List<ProjectFreelancerModel>>> with UseApi {
  ProjectFreelancerProvider() : super(const AsyncValue.loading()) {
    getProjectFree();
    }

  Future<void> getProjectFree() async {
  try {
    state = const AsyncValue.loading();

    ResHandler res = await projectFreelancerApi.getProjectFreelancer();

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

final projectFreelancer =
    StateNotifierProvider.autoDispose<ProjectFreelancerProvider, AsyncValue<List<ProjectFreelancerModel>>>((ref) {
  return ProjectFreelancerProvider();
});


