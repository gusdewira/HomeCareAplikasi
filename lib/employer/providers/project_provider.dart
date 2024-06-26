import 'package:fetchly/fetchly.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class ProjectProvider
    extends StateNotifier<AsyncValue<List<ProjectEmployerModel>>> with UseApi1 {
  ProjectProvider() : super(const AsyncValue.loading()) {
    getProject();
  }

  Future<void> getProject() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectsApi.getProject();

      if (res.status) {
        dynamic data = res.data;
        if (data is List) {
          state = AsyncValue.data(
              data.map((e) => ProjectEmployerModel.fromJson(e)).toList());
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

  Future<bool> getProjectEmployerQuery(Map<String, dynamic> query) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectsApi.getProjectQuery(query);

      if (res.status) {
        dynamic data = res.data;
        LzToast.show("Filtered data success!!");
        if (data is List) {
          state = AsyncValue.data(
              data.map((e) => ProjectEmployerModel.fromJson(e)).toList());
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

final projectProvider = StateNotifierProvider.autoDispose<ProjectProvider,
    AsyncValue<List<ProjectEmployerModel>>>((ref) {
  return ProjectProvider();
});
