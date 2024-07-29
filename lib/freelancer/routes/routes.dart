import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/employer/screens/explore_employer/profille_freelancer.dart';
import 'package:homecare_app/employer/screens/home_employer/widget/belancewithdraw_employer.dart';
import 'package:homecare_app/employer/screens/home_employer/widget/posting_project.dart';
import 'package:homecare_app/employer/screens/home_employer/widget/recenttransaction_employee.dart';
import 'package:homecare_app/employer/screens/home_employer/widget/topup_employer.dart';
import 'package:homecare_app/employer/screens/project_employer/widget/see_history_progress.dart';
import 'package:homecare_app/freelancer/data/local/storage.dart';

import '../../home_page.dart';
import '../../home_page2.dart';
import '../screens/explore/content_widget/bid_explore.dart';
import '../screens/home/views/click_notification.dart';
import '../screens/home/views/invoice_recent_transaction.dart';
import '../screens/home/views/my_portofolios.dart';
import '../screens/home/views/notification_home.dart';
import '../screens/home/views/profile_home_view.dart';
import '../screens/home/views/recent_transaction_view.dart';
import '../screens/login/views/forgetpass.dart';
import '../screens/login/views/forgetpass_verifcode.dart';
import '../screens/login/views/form_regist.dart';
import '../screens/login/views/login_view.dart';
import '../screens/login/views/splash_screen.dart';
import '../screens/project/tabbar_view/tabbar1/detail_bid_project.dart';
import '../screens/project/tabbar_view/tabbar2/detail_progress_project.dart';
import '../screens/project/tabbar_view/tabbar2/history_progress_project.dart';
import '../screens/project/tabbar_view/tabbar2/send_progres.dart';
import '../screens/project/tabbar_view/tabbar3/detail_past_project.dart';
import '../screens/setting/widgets/addmore_experience.dart';
import '../screens/setting/widgets/addmore_portofolio.dart';
import '../screens/setting/widgets/addmore_qualification.dart';
import '../screens/setting/widgets/addmore_skills.dart';
import '../screens/setting/widgets/edit_profile.dart';
import '../screens/setting/widgets/my_profile.dart';
import '../screens/setting/widgets/payment_account.dart';
import 'paths.dart';


final GoRouter router = GoRouter(
  routes: <RouteBase>[
       GoRoute(
      path: Paths.splashscreen,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
  Route.set(Paths.login, (state) => const LoginView()),
    Route.set(Paths.home, (state) => const HomePage(), redirect: (_) => _redirect()),
   
    
     GoRoute(
      path: Paths.signup,
      builder: (BuildContext context, GoRouterState state) {
        return const RegistView();
      },
    ),
     GoRoute(
      path: Paths.forgetpass,
      builder: (BuildContext context, GoRouterState state) {
        return const ForgetPass();
      },
    ),
    GoRoute(
      path: Paths.forgetpassSendKode,
      builder: (BuildContext context, GoRouterState state) {
        return  const ForgetpassVerifCode();
      },
    ),
  
    GoRoute(
      path: Paths.home2,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage2();
      },
    ),
    GoRoute(
      path: Paths.profileHome,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileHome();
      },
    ),
    GoRoute(
      path: Paths.addmoreportofolio,
      builder: (BuildContext context, GoRouterState state) {
        return const AddMorePortofolio();
      },
    ),
    GoRoute(
      path: Paths.addmoreexperience,
      builder: (BuildContext context, GoRouterState state) {
        return AddMoreExperience();
      },
    ),
    GoRoute(
      path: Paths.addmorequalification,
      builder: (BuildContext context, GoRouterState state) {
        return AddMoreQualification();
      },
    ),
    GoRoute(
      path: Paths.addmoreskills,
      builder: (BuildContext context, GoRouterState state) {
        return AddMoreSkill();
      },
    ),
    GoRoute(
      path: Paths.myprofile,
      builder: (BuildContext context, GoRouterState state) {
        return const MyProfile();
      },
    ),
     GoRoute(
      path: Paths.editprofile,
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfile();
      },
    ),
     GoRoute(
      path: Paths.paymentaccount,
      builder: (BuildContext context, GoRouterState state) {
        return const PaymentAccount();
      },
    ),
    GoRoute(
      path: Paths.myPortofolios,
      builder: (BuildContext context, GoRouterState state) {
        return const MyPortofolios();
      },
    ),
    GoRoute(
      path: Paths.notificationHome,
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationHome();
      },
    ),
    GoRoute(
      path: Paths.clickNotification,
      builder: (BuildContext context, GoRouterState state) {
        return const ClickNotification();
      },
    ),
     GoRoute(
      path: Paths.recentTransaction,
      builder: (BuildContext context, GoRouterState state) {
        return const RecentTransactionView();
      },
    ),
    GoRoute(
      path: Paths.invoiceRecentTransaction,
      builder: (BuildContext context, GoRouterState state) {
        return const InvoiceRecentTransaction();
      },
    ),
    GoRoute(
      path: Paths.detailBidProject,
      builder: (BuildContext context, GoRouterState state) {
        return const DetailBidProject();
      },
    ),
    GoRoute(
      path: Paths.detailProgressProject,
      builder: (BuildContext context, GoRouterState state) {
        return const DetailProgressProject();
      },
    ),GoRoute(
      path: '${Paths.historyProgress}/:id',
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id'];
        return HistoryProgress(id: int.parse(id!));
      },
    ),GoRoute(
      path: Paths.detailPastProject,
      builder: (BuildContext context, GoRouterState state) {
        return const DetailPastProject();
      },
    ),
    GoRoute(
      path: Paths.sendProgressProject,
      builder: (BuildContext context, GoRouterState state) {
        return const SendProgressProject();
      },
    ),
    GoRoute(
      path: Paths.bidExplore,
      builder: (BuildContext context, GoRouterState state) {
        return const BidExplore();
      },
    ),












    //employer
    GoRoute(
      path: Paths.profileFreelancerEx,
      builder: (BuildContext context, GoRouterState state) {
        return ProfileFreelancerEx();
      },
    ),
    GoRoute(
      path: Paths.belanceWithDrawEmployer,
      builder: (BuildContext context, GoRouterState state) {
        return const BelanceWithDrawEmployer();
      },
    ),
    GoRoute(
      path: Paths.topUpEmployer,
      builder: (BuildContext context, GoRouterState state) {
        return const TopUpEmployer();
      },
    ),
    GoRoute(
      path: Paths.recentTransactionEmployer,
      builder: (BuildContext context, GoRouterState state) {
        return const RecentTransactionEmployer();
      },
    ),
    GoRoute(
      path: Paths.postingProjectEmployer,
      builder: (BuildContext context, GoRouterState state) {
        return const PostingProjectEmployer();
      },
    ),
    GoRoute(
      path: Paths.seeHistoryProgressEmployer,
      builder: (BuildContext context, GoRouterState state) {
        return const SeeHistoryProgressEmployer();
      },
    ),
  ],
);




String _redirect() {
  String? token = prefs.getString('token');
  print('token = $token' );
  return token == null ? Paths.login:Paths.home;
}

class Route {
  static GoRoute set(String path, Widget Function(GoRouterState state) builder,
      {FutureOr<String?> Function(GoRouterState)? redirect}) {
    return GoRoute(
      path: path,
      builder: (BuildContext context, GoRouterState state) => builder(state),
      redirect: (_, GoRouterState state) => redirect?.call(state),
);
}
}