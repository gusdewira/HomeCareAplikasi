import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:homecare_app/freelancer/data/api/api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier, UseApi {
  Future<bool> logout() async {
    try {
      ResHandler res = await authApi.logout();
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (res.status) {
        await prefs.remove('token');
        dio.options.headers.remove('Authorization');
        return true;
      }

      return res.status;
    } catch (e) {
      print('Logout failed: $e');
      return false;
    }
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider());
