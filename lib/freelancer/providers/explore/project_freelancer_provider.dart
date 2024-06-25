import 'package:fetchly/fetchly.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class ProjectFreelancerProvider
    extends StateNotifier<AsyncValue<List<ProjectFreelancerModel>>> with UseApi {
  ProjectFreelancerProvider() : super(const AsyncValue.loading()) {
    getProjectFreelancer();
  }

  Future<void> getProjectFreelancer() async {
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

  Future<bool> getProjectFreelancerQuery(Map<String, dynamic> query) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectFreelancerApi.getProjectFreelancerQuery(query);

      if (res.status) {
        dynamic data = res.data;
        LzToast.show("Filtered data success!!");
        if (data is List) {
          state = AsyncValue.data(data.map((e) => ProjectFreelancerModel.fromJson(e)).toList());
        } else {
          LzToast.show("Unexpected data type received");
        }
        return true;
      } else {
        LzToast.show(res.message);
        return false;
      }
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }
}

final projectFreelancer =
    StateNotifierProvider.autoDispose<ProjectFreelancerProvider, AsyncValue<List<ProjectFreelancerModel>>>((ref) {
  return ProjectFreelancerProvider();
});
