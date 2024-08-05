import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fetchly/fetchly.dart';
import 'package:lazyui/lazyui.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/experience_model.dart';

class ExperienceProvider
    extends StateNotifier<AsyncValue<List<ExperienceModel>>> with UseApi {
  ExperienceProvider() : super(const AsyncValue.loading()) {
    getEx();
  }

  final forms = LzForm.make(
      ['title', 'company', 'description', 'start_date', 'end_date']);

  Future<void> getEx() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await experienceApi.getExperience();

      if (res.status) {
        List data = res.data ?? [];
        state = AsyncValue.data(
            data.map((e) => ExperienceModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<bool> postEx(int? id) async {
    try {
      final form = forms.validate(
          required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {
            "title": "The Title form must be filled in",
            "company": "The Company form must be filled in",
            "description": "The Description form must be filled in",
            "start_date": "Please enter the Start Date",
            "end_date": "Please enter the End Date",
          }));

      if (!form.ok) {
        LzToast.show("Please fill all required fields.");
        return false;
      }

      if (form.ok) {
        ResHandler res;
        if (id == null) {
          res = await experienceApi.postExperience(form.value);
        } else {
          res = await experienceApi.updateExperience(form.value, id);
        }

        if (res.status) {
          final experience = ExperienceModel.fromJson(res.data ?? {});

          state.whenData((data) {
            if (id == null) {
              data.add(experience);
            } else {
              data[data.indexWhere((element) => element.id == id)] = experience;
            }
            state = AsyncValue.data(data);
          });
        } else {
          if (res.message ==
              "The end date field must be a date after start date.") {
            LzToast.show("The end date must be after the start date.");
          } else {
            LzToast.show(res.message);
          }
        }

        return res.status;
      }

      return false;
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }

  Future delEx(int id) async {
    try {
      LzToast.overlay('Deleting...');
      ResHandler res = await experienceApi.deleteExperience(id);

      if (res.status) {
        state.whenData((data) {
          data.removeWhere((element) => element.id == id);
          state = AsyncValue.data(data);
        });

        LzToast.show('has been deleted.');
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      LzToast.dismiss();
    }
  }
}

final experienceProvider = StateNotifierProvider.autoDispose<ExperienceProvider,
    AsyncValue<List<ExperienceModel>>>((ref) {
  return ExperienceProvider();
});
