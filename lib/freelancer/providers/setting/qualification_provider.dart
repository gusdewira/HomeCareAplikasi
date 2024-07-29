import 'dart:io';
import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/qualification_model.dart';

class QualificationProvider
    extends StateNotifier<AsyncValue<List<QualificationModel>>> with UseApi {
  QualificationProvider() : super(const AsyncValue.loading()) {
    getQualif();
  }

  Future<void> getQualif() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await qualificationApi.getQualification();

      if (res.status) {
        List data = res.data ?? [];
        state = AsyncValue.data(
            data.map((e) => QualificationModel.fromJson(e)).toList());
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

final qualificationProvider = StateNotifierProvider.autoDispose<
    QualificationProvider, AsyncValue<List<QualificationModel>>>((ref) {
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

  Future<bool> qualifiPost(BuildContext context) async {
    try {
      final form = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: true,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {
            "title": "The title form must be filled in",
            "org_qualification":
                "The Organization Qualification form must be filled in",
            "date": "The date form must be filled in"
          }));

      if (!form.ok) {
        LzToast.show('Please fill all required fields.');
        return false;
      }

      final payload = form.value;

      if (fileAttachment != null) {
        if (fileAttachment!.existsSync()) {
          payload['attachment'] =
              await qualificationApi.toFile(fileAttachment!.path);
        } else {
          LzToast.show('Attachment file is missing.');
          return false;
        }
      } else {
        LzToast.show('Please attach a file.');
        return false;
      }

      LzToast.overlay('Loading...');

      ResHandler res = await qualificationApi.postQualification(payload);

      if (res.status) {
        LzToast.show('Qualification has been created.');
        return true;
      } else {
        LzToast.show(res.message);
        return false;
      }
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('Error occurred while creating qualification.');
      return false;
    } finally {
      LzToast.dismiss();
    }
  }

  Future<bool> qualifiEdit(BuildContext context, int id) async {
    try {
      final form = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: true,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {
            "title": "The title form must be filled in",
            "org_qualification":
                "The Organization Qualification form must be filled in",
            "date": "The date form must be filled in"
          }));

      if (!form.ok) {
        print(form.value);
        LzToast.show('Please fill all required fields.');
        return false;
      }

      final payload = form.value;

      payload['_method'] = "put";

      if (fileAttachment != null) {
        if (fileAttachment!.existsSync()) {
          payload['attachment'] = fileAttachment!.path;
        } else {
          LzToast.show('Attachment file is missing.');
          return false;
        }
      } else {
        LzToast.show('Please attach a file.');
        return false;
      }

      LzToast.overlay('Loading...');

      ResHandler res = await qualificationApi.updateQualification(payload, id);

      if (res.status) {
        LzToast.show('Qualification has been updated.');
        return true;
      } else {
        LzToast.show(res.message);
        return false;
      }
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('Error occurred while updating qualification.');
      return false;
    } finally {
      LzToast.dismiss();
    }
  }
}

final qualificationPostProvider =
    ChangeNotifierProvider((ref) => QualificationPostProvider());
