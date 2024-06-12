
import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/api/api.dart';
import '../../data/local/storage.dart';
import '../../routes/paths.dart';

// class Auth with ChangeNotifier, UseApi {
//   final forms = LzForm.make(['email', 'password']);

//   Future login(BuildContext context) async {
//     try {
//       final form = LzForm.validate(forms, required: ['*']);

//       if (form.ok) {
//         LzToast.overlay('Logging in...');
//         ResHandler res = await authApi.login(form.value);

//         if (!res.status) {
//           return LzToast.show(res.message);
//         }

//         String? token = res.data['token'];
//         String? role = res.data['role']; // Assuming the role is returned in the response

//         // Log the response for debugging
//         print('Response: ${res.data}');

//         if (token != null && role != null) {
//           if (!context.mounted) return;

//           // Set token to dio
//           dio.setToken(token);

//           // Save token to shared preferences
//           prefs.setString('token', token);
//           prefs.setString('role', role); // Optionally save the role if needed later

//           // Navigate based on role
//           if (role == 'employer') {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomeViewEmployer()),
//             );
//           } else if (role == 'freelancer') {
//             context.go(Paths.home);
//           } else {
//             LzToast.show('Role is not recognized.');
//           }
//         } else {
//           LzToast.show('Token or role is missing.');
//         }
//       } else {
//         LzToast.show('Form validation failed.');
//       }
//     } catch (e, s) {
//       print('Exception: $e\nStack trace: $s'); // Log exception
//       Errors.check(e, s);
//     } finally {
//       LzToast.dismiss();
//     }
//   }
// }

// final authProvider = ChangeNotifierProvider((ref) => Auth());


class Auth with ChangeNotifier, UseApi {
  final forms = LzForm.make(['email', 'password']);

  Future login(BuildContext context) async {
    try {
      final form = LzForm.validate(forms, required: ['*']);

      if (form.ok) {
        LzToast.overlay('Logging in...');

        ResHandler res = await authApi.login(form.value);
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

          // go to home
          context.go(Paths.home);
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}

final authProvider = ChangeNotifierProvider((ref) => Auth());