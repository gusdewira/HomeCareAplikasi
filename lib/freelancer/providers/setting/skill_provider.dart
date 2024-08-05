import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:fetchly/fetchly.dart';
import '../../data/api/api.dart';
import '../../data/models/setting/skill_model.dart';

class SkillProvider extends StateNotifier<AsyncValue<List<SkillModel>>> with UseApi {
  SkillProvider() : super(const AsyncValue.loading()) {
    getSkil();
  }

  final forms = LzForm.make(['skill_name', 'description',]);

  Future<void> getSkil() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await skillApi.getSkill();

      if (res.status) {
        List data = res.data ?? [];
        state = AsyncValue.data(data.map((e) => SkillModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<bool> postSkil(int? id) async {
    try {
      final form = forms.validate(
        required: ['*'],
          singleNotifier: false,
          notifierType: LzFormNotifier.text,
          messages: FormMessages(required: {
            "skill_name": "The Skill Name form must be filled in",
            "description": "The Description form must be filled in",
          })
      );

      if (form.ok) {
        ResHandler res;
        
        if (id == null) {
          res = await skillApi.postSkill(form.value);
        } else {
          res = await skillApi.updateSkill(form.value, id);
        }

        if (res.status) {
          final skill = SkillModel.fromJson(res.data ?? {});

          state.whenData((data) {
            if (id == null) {
              data.add(skill);
            } else {
              data[data.indexWhere((element) => element.id == id)] = skill;
            }
            state = AsyncValue.data(data);
          });

          return true;
        } else {
          LzToast.show(res.message);
        }
      }
      return false;
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }

  Future<void> delSkill(int id) async {
    try {
      LzToast.overlay('Deleting...');
      ResHandler res = await skillApi.deleteSkill(id);

      if (res.status) {
        state.whenData((data) {
          data.removeWhere((element) => element.id == id);
          state = AsyncValue.data(data);
        });

        LzToast.show('Skill has been deleted.');
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

final skillProvider =
    StateNotifierProvider.autoDispose<SkillProvider, AsyncValue<List<SkillModel>>>((ref) {
  return SkillProvider();
});
