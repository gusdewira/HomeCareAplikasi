import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';

class BidProvider with ChangeNotifier, UseApi {
  final forms =
      LzForm.make(['offer_amount', 'estimated_duration', 'offer_reason']);

  Future postbid(BuildContext context, int id) async {
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

        if (!res.status) {
          forms.reset();
          LzToast.show(res.message);

          Navigator.pop(context);
        } else {
          forms.reset();
          LzToast.show('Offer successfully sent');

          Navigator.pop(context);
        }
      }
    } catch (e, s) {
      logg('Error: $e, StackTrace: $s');
      LzToast.show('An error occurred during postbid.');
    } finally {
      LzToast.dismiss();
    }
  }
}

final bidProvider = ChangeNotifierProvider((ref) => BidProvider());
