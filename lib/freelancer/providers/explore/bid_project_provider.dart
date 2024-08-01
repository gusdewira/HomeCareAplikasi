import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';

class BidProvider with ChangeNotifier, UseApi {
  final forms =
      LzForm.make(['offer_amount', 'estimated_duration', 'offer_reason']);

  Future<Map<String, dynamic>> postbid(BuildContext context, int id) async {
    try {
      final form = LzForm.validate(forms,
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {
            "offer_amount": "The Bid Amount form must be filled in",
            "estimated_duration": "The Estimed Duration form must be filled in",
            "offer_reason": "The Reason form must be filled in",
          }));

      final payload = form.value;
      if (form.ok) {
        LzToast.overlay('send an offer');

        payload['project_id'] = id;
        ResHandler res = await bidProjectApi.postBidProject(payload);

        print(res.message);
        print(res.data);
        print(res.status);
        if (res.status) {
          forms.reset();

          LzToast.show(res.message);
          Navigator.pop(context);
          LzToast.dismiss();
          return {"status": res.status, "data": res.data};
        } else {
          forms.reset();
          LzToast.show(res.message);

          Navigator.pop(context);
          LzToast.dismiss();
          return {"status": res.status, "data": res.data};
        }
      }
      LzToast.dismiss();
      return {"status": false, "data": {}};
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('An error occurred during postbid.');
      return {"status": false, "data": {}};
    } finally {
      LzToast.dismiss();
    }
  }
}

final bidProvider = ChangeNotifierProvider((ref) => BidProvider());
