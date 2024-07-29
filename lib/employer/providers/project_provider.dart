import 'dart:io';

import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
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
        List data = res.data;
        state = AsyncValue.data(
            data.map((e) => ProjectEmployerModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      print("Error: $e");
      Errors.check(e, s);
    }
  }
}

final projectProvider = StateNotifierProvider.autoDispose<ProjectProvider,
    AsyncValue<List<ProjectEmployerModel>>>((ref) {
  return ProjectProvider();
});

class ProjectQueryProvider
    extends StateNotifier<AsyncValue<List<ProjectEmployerModel>>> with UseApi1 {
  final Map<String, dynamic> query;
  ProjectQueryProvider(this.query) : super(const AsyncValue.loading()) {
    getProjectEmployerQuery(query);
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

final projectQueryProvider = StateNotifierProvider.autoDispose.family<
    ProjectQueryProvider,
    AsyncValue<List<ProjectEmployerModel>>,
    Map<String, dynamic>>((ref, query) {
  return ProjectQueryProvider(query);
});

class PostProjectNotifier with ChangeNotifier, UseApi1 {
  final forms = LzForm.make([
    'title',
    'description',
    'name_category',
    'longitude',
    'latitude',
    'start_date',
    'end_date',
    'start_salary',
    'end_salary'
  ]);

  File? fileAttachment;

  void setFile(File value) {
    fileAttachment = value;
    notifyListeners();
  }

  Future create(BuildContext context) async {
    try {
      final validate = LzForm.validate(
        required: ["*"],
        forms,
      );

      if (validate.ok && fileAttachment != null) {
        final map = forms.toMap();

        LzToast.overlay('Loading Post Project...');
        if (map['name_category'] is String) {
          map['name_category[0]'] = map['name_category'];
        }

        if (fileAttachment!.existsSync()) {
          final attachment = await projectsApi.toFile(fileAttachment!.path);
          map['attachment'] = attachment;
        } else {
          LzToast.show("Attachment file is missing.");
        }

        ResHandler res = await projectsApi.postProject(map);

        LzToast.dismiss();
        if (!res.status) {
          LzToast.show(res.message);
          return false;
        } else {
          forms.reset();
          LzToast.show('Successfully created new project...');

          Navigator.pop(context);
          return true;
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final postProjectNotifier =
    ChangeNotifierProvider((ref) => PostProjectNotifier());
