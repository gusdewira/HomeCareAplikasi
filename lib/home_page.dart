import 'package:flutter/material.dart';
import 'package:homecare_app/freelancer/core/extensions/riverpod_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'freelancer/providers/app_provider.dart';
import 'freelancer/screens/explore/views/explore_view.dart';
import 'freelancer/screens/home/views/home_view.dart';
import 'freelancer/screens/project/views/project_view.dart';
import 'freelancer/screens/setting/views/setting_view.dart';
import 'freelancer/screens/support/views/support_view.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> pages = const [
      ExploreView(),
      HistoryView(),
      HomeView(),
      SupportView(),
      SettingView(),
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
                                      offset: isActive? const Offset(0, -20) : Offset.zero,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isActive? LzColors.hex('0047E3') : Colors.transparent,
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            icon,
                                            color: isActive? Colors.white : colorActive,
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
