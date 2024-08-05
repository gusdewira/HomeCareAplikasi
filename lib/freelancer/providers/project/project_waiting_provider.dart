import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class ProjectBidProvider
    extends StateNotifier<AsyncValue<List<ProjectFreelancerModel>>> with UseApi {
  ProjectBidProvider() : super(const AsyncValue.loading()) {
    getProjectBid();
    }

  Future<void> getProjectBid() async {
  try {
    state = const AsyncValue.loading();

    ResHandler res = await projectBidApi.getProjectBid();

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

final projectBid =
    StateNotifierProvider.autoDispose<ProjectBidProvider, AsyncValue<List<ProjectFreelancerModel>>>((ref) {
  return ProjectBidProvider();
});
