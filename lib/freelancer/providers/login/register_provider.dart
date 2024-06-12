import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/api/api.dart';
import '../../data/local/storage.dart';
import '../../routes/paths.dart';

class Register with ChangeNotifier, UseApi {
  final forms = LzForm.make([
    'first_name',
    'last_name',
    'number_phone',
    'address',
    'email',
    'password',
    'retype_password',
    'role'
  ]);

  Future register(BuildContext context) async {
    try {
      final form = LzForm.validate(forms, required: ['*']);

      if (form.ok) {
        LzToast.overlay('Logging in...');
        ResHandler res = await registerApi.register(form.value);

        if (!res.status) {
          return LzToast.show(res.message);
        }

        String? token = res.data['token'];

        if (token != null) {
          if (!context.mounted) return;

          // set token to dio
          dio.setToken(token);

          // save token to shared preferences
          prefs.setString('token', token);

        }
        context.go(Paths.login);
        return LzToast.show("Register success");
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}

final registerProvider = ChangeNotifierProvider((ref) => Register());
