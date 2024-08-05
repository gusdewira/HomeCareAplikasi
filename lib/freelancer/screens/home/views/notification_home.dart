import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/models/notification_model.dart';
import 'package:homecare_app/employer/providers/notification_provider.dart';
import 'package:homecare_app/freelancer/screens/home/views/click_notification.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/color_widget.dart';

class NotificationHome extends ConsumerStatefulWidget {
  const NotificationHome({super.key});

  @override
  _NotificationHomeState createState() => _NotificationHomeState();
}

class _NotificationHomeState extends ConsumerState<NotificationHome> {
  final TextEditingController _controller = TextEditingController();
  List<NotificationModel> _filteredNotifications = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_filterNotifications);
  }

  @override
  void dispose() {
    _controller.removeListener(_filterNotifications);
    _controller.dispose();
    super.dispose();
  }

  void _filterNotifications() {
    final searchTerm = _controller.text.toLowerCase();
    final notifications = ref.read(notificationProvider);
    notifications.when(
      data: (List<NotificationModel> notifications) {
        setState(() {
          _filteredNotifications = notifications.where((item) {
            final title = item.title?.toLowerCase() ?? '';
            final description = item.notifText?.toLowerCase() ?? '';
            return title.contains(searchTerm) || description.contains(searchTerm);
          }).toList();
        });
      },
      error: (error, _) {
        setState(() {
          _filteredNotifications = [];
        });
      },
      loading: () {
        setState(() {
          _filteredNotifications = [];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationProvider);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              color3,
              color4,
            ],
            stops: const [
              0.0,
              0.6
            ]),
      ),
      child: Stack(
        children: [
          Container(
            margin: Ei.only(t: 120),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: color2,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Ti.chevronLeft,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Textr(
                'Notification',
                style: Gfont.white.bold.fsize(18),
              ),
            ),
          ),

          Positioned(
            top: 125,
            left: 25,
            right: 25,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 210,
              child: notifications.when(
                data: (List<NotificationModel> notification) {
                  final displayedNotifications = _filteredNotifications.isEmpty
                      ? notification
                      : _filteredNotifications;

                  if (displayedNotifications.isEmpty) {
                    return const Center(
                      child: Text("Notifications is empty"),
                    );
                  }

                  return ListView.builder(
                    itemCount: displayedNotifications.length,
                    itemBuilder: (context, index) {
                      final notif = displayedNotifications[index];
                      final title = notif.title ?? "No Title";
                      final description = notif.notifText ?? "No Description";
                      final sender =
                          '${notif.sentTo?.firstName ?? ""} ${notif.sentTo?.lastName ?? ""}';

                      return InkTouch(
                        onTap: () {
                          context.lzPush(const ClickNotification());
                        },
                        child: Container(
                          margin: Ei.only(t: 10),
                          padding: Ei.only(b: 10),
                          decoration: BoxDecoration(
                            color: LzColors.hex('FFFFFF'),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: Ei.only(l: 10),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: LzColors.hex('E6E6E8'),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Ti.bell,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: Gfont.color(LzColors.hex('747474')).fsize(12).bold,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      description,
                                      style: Gfont.color(LzColors.hex('747474')).fsize(12),
                                    ),
                                    const SizedBox(height: 6),
                                    Opacity(
                                      opacity: 0.5,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.account_circle,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(sender),
                                        ],
                                      ),
                                    ),
                                  ],
                                ).margin(t: 18, l: 10),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, _) {
                  return LzNoData(message: 'Oops! $error');
                },
                loading: () => LzLoader.bar(message: 'Loading...'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
