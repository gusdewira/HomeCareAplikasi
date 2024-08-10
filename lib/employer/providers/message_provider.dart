import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/api/api.dart';
import 'package:homecare_app/employer/data/models/message_model.dart';
import 'package:homecare_app/employer/data/models/project_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';

class MessageProvider extends StateNotifier<AsyncValue<List<MessageModel>>>
    with UseApi1 {
  MessageProvider() : super(const AsyncValue.loading()) {
    getMessage();
  }

  Future<void> getMessage() async {
    try {
      state = const AsyncValue.loading();
      print("Fetching messages...");

      ResHandler res = await messageApi.getMessage();
      print("Response Status: ${res.status}");
      print("Response Data: ${res.data}");
      print("Response Message: ${res.message}");

      if (res.status) {
        List data = res.body['messages'];
        state =
            AsyncValue.data(data.map((e) => MessageModel.fromJson(e)).toList());
        print("State updated with data.");
      } else {
        LzToast.show(res.message);
        state = AsyncValue.error(
            res.message ?? 'Unknown error', StackTrace.current);
        print("Error State: ${res.message}");
      }
    } catch (e, s) {
      print("Exception: $e");
      print("Stacktrace: $s");
      Errors.check(e, s);
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

final messageProvider = StateNotifierProvider.autoDispose<MessageProvider,
    AsyncValue<List<MessageModel>>>((ref) {
  return MessageProvider();
});

class PostMessage with ChangeNotifier, UseApi1 {
  final forms = LzForm.make(['message_text', 'conversation_id']);

  Future<bool> create(Map<String, dynamic> data) async {
    try {
      if (data.isNotEmpty) {
        ResHandler res = await messageApi.postMessage(data);

        LzToast.dismiss();
        if (!res.status) {
          LzToast.show(res.message);
          return false;
        } else {
          forms.reset();
          LzToast.show('Successfully send new message...');
          return true;
        }
      }
      return false;
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }

  Future<bool> update(Map<String, dynamic> data, int id) async {
    try {
      if (data.isNotEmpty) {
        ResHandler res = await messageApi.updateMessage(data, id);

        LzToast.dismiss();
        if (!res.status) {
          LzToast.show(res.message);
          return false;
        } else {
          forms.reset();
          LzToast.show('Successfully update message...');
          return true;
        }
      }
      return false;
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      ResHandler res = await messageApi.deleteMessage(id);

      LzToast.dismiss();
      if (!res.status) {
        LzToast.show(res.message);
        return false;
      } else {
        forms.reset();
        LzToast.show('Successfully delete message...');
        return true;
      }
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }
}

final postMessage = ChangeNotifierProvider((ref) => PostMessage());
