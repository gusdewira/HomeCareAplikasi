import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class ProjectComplatedProvider
    extends StateNotifier<AsyncValue<List<ProjectFreelancerModel>>> with UseApi {
  ProjectComplatedProvider() : super(const AsyncValue.loading()) {
    getProjectComplated();
    }

  Future<void> getProjectComplated() async {
  try {
    state = const AsyncValue.loading();

    ResHandler res = await projectComplatedApi.getProjectComplated();

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

final projectComplated =
    StateNotifierProvider.autoDispose<ProjectComplatedProvider, AsyncValue<List<ProjectFreelancerModel>>>((ref) {
  return ProjectComplatedProvider();
});
