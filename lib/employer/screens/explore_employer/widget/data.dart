import 'package:flutter/material.dart';
import 'package:homecare_app/employer/providers/conversation_provider.dart';
import 'package:homecare_app/employer/providers/message_provider.dart';
import 'package:homecare_app/employer/screens/explore_employer/profille_freelancer.dart';
import 'package:homecare_app/employer/screens/message_employer/message_page.dart';
import 'package:homecare_app/freelancer/data/models/setting/profile_freelancer_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class DataExploreFreelancer extends ConsumerWidget {
  final FreelancerExplore projectEmployee;

  const DataExploreFreelancer({super.key, required this.projectEmployee});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String formatNumber(double number) {
      final formatCurrency = NumberFormat.currency(
          locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
      return formatCurrency.format(number);
    }

    Future<void> handleTap(int id) async {
      final notifier = ref.read(postConversation.notifier);
      final notifier2 = ref.read(postMessage.notifier);

      Map<String, dynamic> ok = await notifier.create({"user2_id": id});

      if (ok['status']) {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            String message = '';

            return AlertDialog(
              title: const Text('Kirim Pesan'),
              content: TextField(
                onChanged: (value) {
                  message = value;
                },
                decoration:
                    const InputDecoration(hintText: "Tulis pesan Anda di sini"),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Batal'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(dialogContext).pop();
                    if (message.isNotEmpty) {
                      Map<String, dynamic> res = await notifier2.create({
                        "message_text": message,
                        "conversation_id": ok["conversationId"]
                      });

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (context.mounted) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MessagePage(
                                senderId: res['message']['sender_id'],
                                conversationId: ok['conversationId'],
                              ),
                            ),
                          );
                        }
                      });
                    } else {
                      print('Message cannot be empty');
                    }
                  },
                  child: const Text('Kirim'),
                ),
              ],
            );
          },
        );
      }
    }

    final name =
        '${projectEmployee.firstName ?? "No First Name"} ${projectEmployee.lastName ?? "No Last Name"}';
    final profession = projectEmployee.profession ?? "Unknown";
    final summary = projectEmployee.summary ?? "No Summary";

    return Container(
      padding: Ei.only(l: 20, r: 20, t: 10),
      margin: Ei.only(l: 25, r: 25, b: 10, t: 10),
      width: context.width / 1,
      height: 220,
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
      child: Column(
        mainAxisSize: Mas.min,
        crossAxisAlignment: Caa.start,
        children: [
          Row(
            children: [
              LzImage(
                projectEmployee.photoProfile,
                radius: 40,
                size: 50,
              ),
              Expanded(
                child: Container(
                  margin: Ei.only(l: 10),
                  width: context.width,
                  height: 50,
                  child: Row(
                    crossAxisAlignment: Caa.start,
                    mainAxisAlignment: Maa.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Textr(
                            name,
                            width: 150,
                            overflow: Tof.ellipsis,
                            style: Gfont.color(LzColors.hex('001380')),
                          ),
                          Textr(
                            profession,
                            overflow: Tof.ellipsis,
                            width: 150,
                            style: Gfont.color(LzColors.hex('B9B9B9')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: context.width,
            height: 80,
            margin: Ei.only(t: 10),
            child: Text(
              maxLines: 4,
              summary,
              style: Gfont.color(LzColors.hex('747474')).fsize(14),
            ),
          ),
          SizedBox(
            width: context.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkTouch(
                  onTap: () {
                    handleTap(projectEmployee.id!);
                  },
                  child: Container(
                    margin: Ei.only(r: 10),
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(color: LzColors.hex('0047E3'), width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: Maa.center,
                      children: [
                        Icon(
                          Ti.message,
                          color: LzColors.hex('0047E3'),
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Textr(
                          alignment: Alignment.center,
                          'Chat',
                          style: Gfont.color(LzColors.hex('0047E3')).fsize(12),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    color: LzColors.hex('0047E3'),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkTouch(
                    onTap: () {
                      context.lzPush(
                          ProfileFreelancerEx(profile: projectEmployee));
                    },
                    child: Textr(
                      alignment: Alignment.center,
                      'Check Profile',
                      style: Gfont.color(LzColors.hex('ffffff')).fsize(12),
                    ),
                  ),
                ),
              ],
            ).margin(t: 15),
          ),
        ],
      ),
    );
  }
}
