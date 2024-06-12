import 'dart:io';
import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/local/storage.dart';
import '../../data/models/setting/qualification_model.dart';

class QualificationProvider
    extends StateNotifier<AsyncValue<List<QualificationModel>>> with UseApi {
  QualificationProvider() : super(const AsyncValue.loading()) {
    getQualif();
  }

  // final forms = LzForm.make([
  //   'title',
  //   'orgQualification',
  //   'date',
  //   'attachment',
  // ]);

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

  // Future<bool> postQualif(int? id) async {
  //   try {
  //     final form = forms.validate(
  //         required: ['*'],
  //         singleNotifier: false,
  //         notifierType: LzFormNotifier.text,
  //         messages: FormMessages(required: {
  //           "title": "The Title form must be filled in",
  //           "org_qualification": "The Company form must be filled in",
  //           "attachment": "Please upload Attachments",
  //           "date": "Please enter the Date",
  //         }));

  //     if (form.ok) {
  //       if (id == null) {
  //         ResHandler res = await qualificationApi.postQualification(form.value);

  //         if (res.status) {
  //           final experience = QualificationModel.fromJson(res.data ?? {});

  //           state.whenData((data) {
  //             data.add(experience);
  //             state = AsyncValue.data(data);
  //           });
  //         }

  //         return res.status;
  //       } else {
  //         ResHandler res =
  //             await qualificationApi.updateQualification(form.value, id);
  //         if (res.status) {
  //           final experience = QualificationModel.fromJson(res.data ?? {});

  //           state.whenData((data) {
  //             data[data.indexWhere((element) => element.id == id)] = experience;
  //             state = AsyncValue.data(data);
  //           });
  //         }
  //         return res.status;
  //       }
  //     }
  //     return false;
  //   } catch (e, s) {
  //     Errors.check(e, s);
  //     return false;
  //   }
  // }

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

// Use Changenotifier
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

  // Add a new field to store the file data

  Future qualifiPost(BuildContext context) async {
    try {
      final form = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {}));

      final payload = form.value;

      if (form.ok && fileAttachment != null) {
        LzToast.overlay('Loading...');

        // Check if the fileAttechment is a valid file

        // Check if the fileAttechment is an image (you may need to adjust this check)

        // Set the fileAttechment field again (this might be unnecessary, check your requirements)
        // payload['fileAttechment'] = fileAttechment;
        //  payload['attachment'] = await qualificationApi.toFile(fileAttachment!.path);

        // Perform member registration
        if (fileAttachment!.existsSync()) {
          // File is valid, proceed with the API request
          // payload['attachment'] = await qualificationApi.toFile(fileAttachment!.path);
        }
        ResHandler res = await qualificationApi.postQualification(payload);

        logg(res.status);

        String? token = res.body['token'];

        if (token != null) {
          if (!context.mounted) return;

          // set token to dio
          dio.setToken(token);

          // save token to shared preferences
          prefs.setString('token', token);

          // go to home
        }
        // ignore: use_build_context_synchronously
        //context.generalDialog(const SyaratDanKententuanPopup());
      }
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('error');
    } finally {
      LzToast.dismiss();
    }
  }
}

final qualificationPostProvider =
    ChangeNotifierProvider((ref) => QualificationPostProvider());
