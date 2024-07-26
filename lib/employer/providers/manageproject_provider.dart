
import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class ApproveProjectNotifier with ChangeNotifier, UseApi1 {
  Future approve(BuildContext context) async {
    try {
        ResHandler res = await projectsApi.approveBid(1);

        LzToast.dismiss();
        print(res.message);
        if (!res.status) {
          LzToast.show(res.message);
          return false;
        } else {
          LzToast.show('Successfully created new project...');

          Navigator.pop(context);
          return true;
        }
      
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final approveProjectNotifier =
    ChangeNotifierProvider((ref) => ApproveProjectNotifier());
