import 'package:flutter/material.dart';
import 'package:homecare_app/employer/screens/message_employer/list_message_employer.dart';
import 'package:homecare_app/freelancer/core/extensions/riverpod_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'employer/screens/explore_employer/explore_view_employer.dart';
import 'employer/screens/home_employer/home_view_employer.dart';
import 'employer/screens/project_employer/project_view_employer.dart';
import 'employer/screens/setting_employer/setting_view_employer.dart';
import 'freelancer/providers/app_provider.dart';

class HomePage2 extends ConsumerWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> pages = [
      const ExploreView(),
      const ProjectEmployerView(),
      const HomeEmployerView(),
      ListMessagePage(),
      const SettingEmployerView(),
    ];
    Utils.setSystemUI(
        navBarColor: Colors.white, navBarIconColor: Brightness.dark);

    return Scaffold(
        body: appStateProvider.watch((state) => Stack(
                children: List<Widget>.generate(5, (int index) {
              bool isActive = state.page == index;

              return IgnorePointer(
                ignoring: !isActive,
                child: AnimatedOpacity(
                  duration: 250.ms,
                  opacity: isActive ? 1 : 0,
                  child: Navigator(
                    key: ValueKey<int>(index),
                    onGenerateRoute: (RouteSettings settings) {
                      return MaterialPageRoute(
                        builder: (_) => pages[index],
                        settings: settings,
                      );
                    },
                  ),
                ),
              );
            }))),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(border: Br.only(['b'])),
          child: appStateProvider.watch(
            (state) => Stack(
              children: [
                Intrinsic(
                  children: [
                    Ti.search,
                    Ti.files,
                    Ti.home,
                    Ti.message2,
                    Ti.settings,
                  ].generate((icon, i) {
                    bool isActive = state.page == i;
                    Color colorActive =
                        isActive ? Colors.black : Colors.black26;

                    return Expanded(
                        child: InkTouch(
                            onTap: () {
                              final notifier =
                                  ref.read(appStateProvider.notifier);
                              notifier.navigateTo(i);
                            },
                            padding: Ei.sym(v: 10, h: 5),
                            color: LzColors.hex('F8F8FF'),
                            child: Column(
                              mainAxisAlignment: Maa.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Transform.translate(
                                      offset: isActive
                                          ? const Offset(0, -20)
                                          : Offset.zero,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isActive
                                              ? LzColors.hex('0047E3')
                                              : Colors.transparent,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            icon,
                                            color: isActive
                                                ? Colors.white
                                                : colorActive,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )));
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
