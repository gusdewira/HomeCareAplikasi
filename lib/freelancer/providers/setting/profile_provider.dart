import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fetchly/fetchly.dart';
import 'package:homecare_app/freelancer/providers/setting/edit_profile_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/api/api.dart';
import '../../data/models/setting/profile_freelancer_model.dart';

// ProfileFreelancerProvider
class ProfileFreelancerProvider
    extends StateNotifier<AsyncValue<ProfileFreelancerModel>> with UseApi {
  ProfileFreelancerProvider() : super(const AsyncValue.loading()) {
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      state = const AsyncValue.loading();
      ResHandler res = await profileFreelancerApi.getProfileFreelancer();
      if (res.status) {
        state =
            AsyncValue.data(ProfileFreelancerModel.fromJson(res.data ?? {}));
      } else {
        LzToast.show(res.message);
        state = AsyncValue.error(
            res.message ?? 'Unknown error occurred', StackTrace.current);
      }
    } catch (e, s) {
      print('Error: $e');
      Errors.check(e, s);
      state = AsyncValue.error(e, s);
    }
  }

  Future<ProfileFreelancerModel> getDataProfile() async {
    try {
      state = const AsyncValue.loading();
      ResHandler res = await profileFreelancerApi.getProfileFreelancer();

      if (res.status) {
        state =
            AsyncValue.data(ProfileFreelancerModel.fromJson(res.data ?? {}));
        return ProfileFreelancerModel.fromJson(res.data ?? {});
      } else {
        LzToast.show(res.message);
        state = AsyncValue.error(
            res.message ?? 'Unknown error occurred', StackTrace.current);
        throw Exception('Failed to fetch profile');
      }
    } catch (e, s) {
      Errors.check(e, s);
      throw Exception('An error occurred');
    }
  }
}

final profileFreelancerProvider = StateNotifierProvider<
    ProfileFreelancerProvider, AsyncValue<ProfileFreelancerModel>>((ref) {
  return ProfileFreelancerProvider();
});

// EditProfilChangeNotifier
class EditProfilChangeNotifier with ChangeNotifier, UseApi {
  final forms = LzForm.make([
    'first_name',
    'last_name',
    'email',
    'number_phone',
    'earning',
    'summary',
    'profession',
    'address'
  ]);

  void fillForm(ProfileFreelancerModel editModel) async {
    forms['first_name']!.controller.text = editModel.firstName ?? '';
    forms['last_name']!.controller.text = editModel.lastName ?? '';
    forms['email']!.controller.text = editModel.email ?? '';
    forms['number_phone']!.controller.text = editModel.numberPhone ?? '';
    forms['earning']!.controller.text =
        editModel.earning.toString().split(".")[0];
    forms['summary']!.controller.text = editModel.summary ?? '';
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
      final validate = LzForm.validate(forms);

      if (validate.ok) {
        final map = forms.toMap();
        LzToast.overlay('Editing profile...');

        map['profile_photo'] = await projectFreelancerApi.toFile(filePath,
            filename: "profile_photo");
        map['_method'] = 'put';
        ResHandler res = await editProfileApi.updateImageProfile(map);
        LzToast.dismiss();

        if (!res.status) {
          forms.reset();
          LzToast.show(res.message);
          Navigator.pop(context);
        } else {
          forms.reset();
          LzToast.show('Successfully Edited Profile Freelancer');
          Navigator.pop(context);
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void pickPortfolio(BuildContext context, id) async {
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
          addPortfolio(context, id);
        }
      });
      filePath = pickedFile.path;
    }
  }

  Future addPortfolio(BuildContext context, int id) async {
    try {
      final map = forms.toMap();
      LzToast.overlay('Add Portfolio...');

      map['portofolio_attachments[1]'] = await projectFreelancerApi
          .toFile(filePath, filename: "portfolio_freelancer");
      map['_method'] = 'put';
      ResHandler res = await editProfileApi.updateImageProfile(map);
      LzToast.dismiss();

      if (!res.status) {
        forms.reset();
        LzToast.show(res.message);
        Navigator.pop(context);
      } else {
        forms.reset();
        LzToast.show('Successfully Add Portfolio Freelancer');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final editProfilChangeNotifier =
    ChangeNotifierProvider((ref) => EditProfilChangeNotifier());

// EditImageChangeNotifier
class EditImageChangeNotifier with ChangeNotifier, UseApi {
  final ImagePicker _picker = ImagePicker();
  final ProfileFreelancerProvider profileProvider;
  File image = File('');
  String filePath = '';

  EditImageChangeNotifier(this.profileProvider);

  void pickImage(BuildContext context, id) async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1500,
        maxHeight: 1500,
        imageQuality: 90);

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
      notifyListeners();
    }
  }

  Future<void> edit(BuildContext context, int id) async {
    try {
      final map = <String, dynamic>{};
      LzToast.overlay('Editing profile...');
      map['profile_photo'] = await projectFreelancerApi.toFile(filePath,
          filename: "profile_photo");
      map['_method'] = 'put';
      ResHandler res = await profileFreelancerApi.updateImageProfile(map);
      LzToast.dismiss();

      if (!res.status) {
        LzToast.show(res.message);
      } else {
        LzToast.show('Successfully Edited Profile Freelancer');
        await profileProvider.getProfile();
        await profileProvider.getDataProfile();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final editImageChangeNotifier = ChangeNotifierProvider((ref) {
  final profileProvider = ref.read(profileFreelancerProvider.notifier);
  return EditImageChangeNotifier(profileProvider);
});
