import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class PostConversation with ChangeNotifier, UseApi1 {
  final forms = LzForm.make(['message_text', 'conversation_id']);

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    try {
      if (data.isNotEmpty) {
        ResHandler res = await conversationApi.postConversation(data);

        LzToast.dismiss();
        if (!res.status) {
          return {"status": false, "conversationId": null};
        } else {
          return {"status": true, "conversationId": res.data['id']};
        }
      }
      return {"status": false, "conversationId": null};
    } catch (e, s) {
      Errors.check(e, s);
      return {"status": false, "conversationId": null};
    }
  }
}

final postConversation = ChangeNotifierProvider((ref) => PostConversation());
