import 'dart:io';

import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/data/models/profile_model.dart';
import 'package:homecare_app/freelancer/providers/setting/edit_profile_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';

class ProfileEmployeeProvider extends StateNotifier<AsyncValue<ProfileEmployerModel>> with UseApi1 {
  ProfileEmployeeProvider() : super(const AsyncValue.loading()) {
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      state = const AsyncValue.loading();
      ResHandler res = await profileEmployeeApi.getProfileEmployee();

      if (res.status) {
        state = AsyncValue.data(ProfileEmployerModel.fromJson(res.data ?? {}));
      } else {
        LzToast.show(res.message);
        state = AsyncValue.error(res.message ?? 'Unknown error occurred', StackTrace.current);
      }
    } catch (e, s) {
      print('Error: $e');
      Errors.check(e, s);
      state = AsyncValue.error(e, s);
    }
  }
}

final profileEmployeeProvider = StateNotifierProvider<ProfileEmployeeProvider, AsyncValue<ProfileEmployerModel>>((ref) {
  return ProfileEmployeeProvider();
});

class EditProfilChangeNotifier with ChangeNotifier, UseApi1 {
  final forms = LzForm.make([
    'first_name',
    'last_name',
    'email',
    'number_phone',
    'profession',
    'address'
  ]);

  void fillForm(ProfileEmployerModel editModel) async {
    forms['first_name']!.controller.text = editModel.firstName ?? '';
    forms['last_name']!.controller.text = editModel.lastName ?? '';
    forms['email']!.controller.text = editModel.email ?? '';
    forms['number_phone']!.controller.text = editModel.numberPhone ?? '';
    forms['profession']!.controller.text = editModel.profession ?? '';
    forms['address']!.controller.text = editModel.address ?? '';
  }

  final ImagePicker _picker = ImagePicker();
  File image = File('');
  String filePath = '';

  void pickImage(BuildContext context, id) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1500,
      maxHeight: 1500,
      imageQuality: 90,
    );

    if (pickedFile != null) {
      showDialog(
          context: context,
          builder: (context) =>
              WidImagePreview(file: File(pickedFile.path))).then((value) {
        if (value != null) {
          image = File(pickedFile.path);
          edit(context, id);
        }
      });
      filePath = pickedFile.path;
    }
  }

  Future edit(BuildContext context, int id) async {
    try {
      final validate = LzForm.validate(
        forms,
      );

      if (validate.ok) {
        final map = forms.toMap();
        LzToast.overlay('Editing profile...');

        map['portofolio_attachment'] = filePath;

        map['_method'] = 'put';
        ResHandler res = await profileEmployeeApi.updateEditProfile(map);

        LzToast.dismiss();
print(res.message);
        if (!res.status) {
          forms.reset();
          LzToast.show(res.message);

          Navigator.pop(context);
        } else {
          forms.reset();
          LzToast.show('Successfully Edited Profile Employee');

          Navigator.pop(context);
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final editProfilChangeNotifier =
    ChangeNotifierProvider((ref) => EditProfilChangeNotifier());
