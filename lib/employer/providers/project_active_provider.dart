import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:homecare_app/freelancer/data/models/project/history_progress_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';

class ProjectActiveProvider
    extends StateNotifier<AsyncValue<List<ProjectEmployerModel>>> with UseApi1 {
  ProjectActiveProvider() : super(const AsyncValue.loading()) {
    getProjectActive();
    }

  Future<void> getProjectActive() async {
  try {
    state = const AsyncValue.loading();

    ResHandler res = await projectActivesApi.getProjectActive();

    if (res.status) {
      dynamic data = res.data;
      if (data is List) {
        state = AsyncValue.data(data.map((e) => ProjectEmployerModel.fromJson(e)).toList());
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

final projectActiveProvider =
    StateNotifierProvider.autoDispose<ProjectActiveProvider, AsyncValue<List<ProjectEmployerModel>>>((ref) {
  return ProjectActiveProvider();
});