library employer_api;
import 'package:fetchly/fetchly.dart';
part 'notification_api.dart';
part 'project_completed_api.dart';
part 'project_api.dart';
part 'profile_api.dart';
part 'project_active_api.dart';
part 'reviews_api.dart';
part 'dashboard_api.dart';
part 'message_api.dart';
part 'conversation_api.dart';

mixin UseApi1 {
  ProfileEmployeeApi profileEmployeeApi = ProfileEmployeeApi();
  ProjectActivesApi projectActivesApi = ProjectActivesApi();
  ProjectsApi projectsApi = ProjectsApi();
  ProjectCompletedApi projectCompletedApi = ProjectCompletedApi();
  DashboardApi dashboardApi = DashboardApi();
  NotificationApi notificationApi = NotificationApi();
  MessageApi messageApi = MessageApi();
  ConversationApi conversationApi = ConversationApi();
}