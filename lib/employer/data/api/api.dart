library employer_api;
import 'package:fetchly/fetchly.dart';
part 'project_completed_api.dart';
part 'project_api.dart';
part 'profile_api.dart';
part 'project_active_api.dart';

mixin UseApi1 {
  ProfileEmployeeApi profileEmployeeApi = ProfileEmployeeApi();
  ProjectActivesApi projectActivesApi = ProjectActivesApi();
  ProjectsApi projectsApi = ProjectsApi();
  ProjectCompletedApi projectCompletedApi = ProjectCompletedApi();
}
