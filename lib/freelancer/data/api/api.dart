library api;

import 'package:fetchly/fetchly.dart';

part 'auth_api.dart';
part 'todo_api.dart';
part 'register_api.dart';
part 'profile_api.dart';
part 'experience_api.dart';
part 'qualification_api.dart';
part 'skill_api.dart';
part 'edit_profile_api.dart';
part 'explore/project_freelancer_api.dart';
part 'explore/bid_project_api.dart';
part 'project/project_waiting_api.dart';
part 'project/project_active_api.dart';
part 'project/project_complated_api.dart';



mixin UseApi {
  AuthApi authApi = AuthApi();
  TodoApi todoApi = TodoApi();
  RegisterApi registerApi = RegisterApi();
  ProfileApi profileFreelancerApi = ProfileApi();
  ExperienceApi experienceApi = ExperienceApi();
  QualificationApi qualificationApi = QualificationApi();
  SkillApi skillApi = SkillApi();
  EditProfileApi editProfileApi = EditProfileApi();
  ProjectFreelancerApi projectFreelancerApi = ProjectFreelancerApi();
  BidProjectApi bidProjectApi = BidProjectApi();
  ProjectBidApi projectBidApi = ProjectBidApi();
  ProjectProgressApi projectProgressApi = ProjectProgressApi();
  ProjectComplatedApi projectComplatedApi = ProjectComplatedApi();
}
