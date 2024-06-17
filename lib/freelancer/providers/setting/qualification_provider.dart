import 'dart:io';
import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/local/storage.dart';
import '../../data/models/setting/qualification_model.dart';

class QualificationProvider extends StateNotifier<AsyncValue<List<QualificationModel>>> with UseApi {
  QualificationProvider() : super(const AsyncValue.loading()) {
    getQualif();
  }

  Future<void> getQualif() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await qualificationApi.getQualification();

      if (res.status) {
        List data = res.data ?? [];
        state = AsyncValue.data(data.map((e) => QualificationModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future delete(int id) async {
    try {
      LzToast.overlay('Deleting...');
      ResHandler res = await qualificationApi.deleteQualification(id);

      if (res.status) {
        state.whenData((data) {
          data.removeWhere((element) => element.id == id);
          state = AsyncValue.data(data);
        });

        LzToast.show('has been deleted.');
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}

final qualificationProvider = StateNotifierProvider.autoDispose<QualificationProvider, AsyncValue<List<QualificationModel>>>((ref) {
  return QualificationProvider();
});

class QualificationPostProvider with ChangeNotifier, UseApi {
  final forms = LzForm.make([
    'title',
    'org_qualification',
    'date',
  ]);

  File? fileAttachment;

  void setFile(File value) {
    fileAttachment = value;
    notifyListeners();
  }

  Future qualifiPost(BuildContext context) async {
    try {
      final form = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {
            "title": "The title form must be filled in",
            "org_qualification": "The Organitation Qualification form must be filled in",
            "attachment": "The attachment form must be filled in"
          }));

      final payload = form.value;

      if (form.ok && fileAttachment != null) {
        LzToast.overlay('Loading...');

        if (fileAttachment!.existsSync()) {
          // File is valid, proceed with the API request
          payload['attachment'] = await qualificationApi.toFile(fileAttachment!.path);
        }

        print(payload);
        ResHandler res = await qualificationApi.postQualification(payload);

        return true;
      }

      return false;
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('error');
    } finally {
      LzToast.dismiss();
    }
  }
}

final qualificationPostProvider = ChangeNotifierProvider((ref) => QualificationPostProvider());
