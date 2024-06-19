import 'package:fetchly/fetchly.dart';
import 'package:homecare_app/freelancer/data/models/project/history_progress_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/project_freelancer_model.dart';

class HistoryProgressProvider
    extends StateNotifier<AsyncValue<HistoryProgressModel>> with UseApi {
  HistoryProgressProvider() : super(const AsyncValue.loading()) {
    getHistoryProgress();
    }

  Future<void> getHistoryProgress() async {
  try {
    state = const AsyncValue.loading();

    ResHandler res = await projectProgressApi.getHistoryProgress(19);

    if (res.status) {
        state = AsyncValue.data(HistoryProgressModel.fromJson(res.data));
    } else {
      LzToast.show(res.message);
    }
  } catch (e, s) {
    Errors.check(e, s);
  }
}
    }

final historyProgress = StateNotifierProvider.autoDispose<HistoryProgressProvider, AsyncValue<HistoryProgressModel>>((ref) {
  return HistoryProgressProvider();
});
