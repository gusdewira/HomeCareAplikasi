import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';

class ProjectCompletedProvider
    extends StateNotifier<AsyncValue<List<ProjectEmployerModel>>> with UseApi1 {
  ProjectCompletedProvider() : super(const AsyncValue.loading()) {
    getProject();
  }

  Future<void> getProject() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectCompletedApi.getProject();

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

  Future<List<ProjectEmployerModel>> getDataProject() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectCompletedApi.getProject();

      if (res.status) {
        dynamic data = res.data;
        if (data is List) {
          state = AsyncValue.data(
              data.map((e) => ProjectEmployerModel.fromJson(e)).toList());
          return data.map((e) => ProjectEmployerModel.fromJson(e)).toList();
        } else {
          LzToast.show("Unexpected data type received");
          throw Exception('Failed to get completed project');
        }
      } else {
        LzToast.show(res.message);
        throw Exception('Failed to get completed project');
      }
    } catch (e, s) {
      Errors.check(e, s);
      throw Exception('An error occurred');
    }
  }
}

final projectCompletedProvider = StateNotifierProvider.autoDispose<
    ProjectCompletedProvider, AsyncValue<List<ProjectEmployerModel>>>((ref) {
  return ProjectCompletedProvider();
});
