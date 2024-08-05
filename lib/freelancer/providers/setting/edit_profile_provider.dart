import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart' hide MultipartFile;
import 'package:fetchly/fetchly.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/profile_freelancer_model.dart';

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
    forms['earning']!.controller.text = editModel.earning ?? '';
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
      final validate = LzForm.validate(
        forms,
      );

      if (validate.ok) {
        final map = forms.toMap();
        LzToast.overlay('Editing profile...');

        map['portofolio_attachment'] = filePath;

        map['_method'] = 'put';
        ResHandler res = await editProfileApi.updateEditProfile(map);

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
}

final editProfilChangeNotifier =
    ChangeNotifierProvider((ref) => EditProfilChangeNotifier());

class EditImageChangeNotifier with ChangeNotifier, UseApi {
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
        Map<String, dynamic> map = {};
        LzToast.overlay('Editing profile...');

        map['portofolio_attachment'] = filePath;

        map['_method'] = 'put';
        ResHandler res = await editProfileApi.updateEditProfile(map);

        LzToast.dismiss();

        if (!res.status) {
          LzToast.show(res.message);

          Navigator.pop(context);
        } else {
          LzToast.show('Successfully Edited Profile Freelancer');

          Navigator.pop(context);
        }

    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final editImageChangeNotifier =
    ChangeNotifierProvider((ref) => EditImageChangeNotifier());

class MemberAssetProvider with ChangeNotifier, UseApi {
  final forms = LzForm.make([
    // Tambahkan definisi formulir yang dibutuhkan
  ]);

  final ImagePicker _picker = ImagePicker();
  File image = File('');
  String filePath = '';

  void pickImage(BuildContext context) async {
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
          changeProfilePicture();
        }
      });
      filePath = pickedFile.path;
    }
  }

  //ChangeProfilePicture
  Future changeProfilePicture() async {
    logg('changeProfilePicture');
    try {
      LzToast.overlay('Mengubah Foto Profile...');

      // create file data
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Send File Image with multipart
      MultipartFile file =
          await MultipartFile.fromFile(filePath, filename: fileName);
      Map<String, dynamic> map = {
        'profile_photo': file,
        '_method': "put",
      };

      ResHandler res = await editProfileApi.updateImageProfile(map);
      LzToast.dismiss();
      if (res.status) {
        // update

        // alert info
        LzToast.show('Foto profil berhasil diperbarui.');
      } else if (res.message != null) {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final changefoto2Provider =
    ChangeNotifierProvider<MemberAssetProvider>((ref) => MemberAssetProvider());

class WidImagePreview extends StatelessWidget {
  final File file;
  const WidImagePreview({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    double size = context.width * .5;

    return CenterDialog(
      child: ClipRRect(
        borderRadius: Br.radius(2),
        child: Container(
          width: context.width,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Container(
                  padding: Ei.sym(v: 35),
                  child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                          borderRadius: Br.circle,
                          image: DecorationImage(
                              image: FileImage(file), fit: BoxFit.cover)))),
              Container(
                width: context.width,
                decoration: BoxDecoration(border: Br.only(['t'])),
                child: Intrinsic(
                  children: List.generate(
                    2,
                    (i) {
                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Br.only([i == 0 ? '' : 'l'])),
                          child: InkTouch(
                            onTap: () {
                              Navigator.pop(context, i == 0 ? null : true);
                            },
                            padding: Ei.sym(v: 15, h: 25),
                            color: Colors.white,
                            child: Text(i == 0 ? 'Batal' : 'Simpan',
                                textAlign: Ta.center),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
