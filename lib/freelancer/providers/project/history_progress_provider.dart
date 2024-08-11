import 'dart:io';

import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:homecare_app/freelancer/data/models/project/history_progress_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';

class HistoryProgressProvider
    extends StateNotifier<AsyncValue<List<HistoryProgressModel>>> with UseApi {
  HistoryProgressProvider() : super(const AsyncValue.loading()) {
    getHistoryProgress();
  }

  Future<void> getHistoryProgress() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await projectProgressApi.getHistoryProgress();

      if (res.status) {
        dynamic data = res.data;
        if (data is List) {
          state = AsyncValue.data(
              data.map((e) => HistoryProgressModel.fromJson(e)).toList());
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

final historyProgressProvider = StateNotifierProvider.autoDispose<
    HistoryProgressProvider, AsyncValue<List<HistoryProgressModel>>>((ref) {
  return HistoryProgressProvider();
});

class ProgressPostProvider with ChangeNotifier, UseApi {
  final forms = LzForm.make([
    'id',
    'title',
    'attachment',
    'description',
  ]);

  File? fileAttachment;

  void setFile(File? value) {
    fileAttachment = value;
    notifyListeners();
  }

  Future progressPost(BuildContext context, String id) async {
    try {
      final form = LzForm.validate(forms,
          required: ['title', 'description'],
          singleNotifier: true,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {
            "title": "The title form must be filled in",
            "description": "The description form must be filled in"
          }));

      final payload = form.value;
      payload['project_accept_id'] = id;

      if (form.ok && fileAttachment != null) {
        LzToast.overlay('Loading...');

        if (fileAttachment!.existsSync()) {
          payload['attachment'] =
              await projectProgressApi.toFile(fileAttachment!.path);
        } else {
          LzToast.show('Attachment file is missing.');
          return false;
        }

        ResHandler res = await projectProgressApi.postProgress(payload);

        forms.reset();
        setFile(null);
        return res;
      }

      return {"status": false, "data": {}};
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('error');
      return {"status": false, "data": {}};
    } finally {
      LzToast.dismiss();
    }
  }
}

final progressPostProvider =
    ChangeNotifierProvider((ref) => ProgressPostProvider());
