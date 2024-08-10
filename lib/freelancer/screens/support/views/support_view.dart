import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/models/message_model.dart';
import 'package:homecare_app/employer/providers/message_provider.dart';
import 'package:homecare_app/freelancer/data/models/setting/profile_freelancer_model.dart';
import 'package:homecare_app/freelancer/screens/support/views/message_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../providers/setting/profile_provider.dart';

class SupportView extends ConsumerStatefulWidget {
  const SupportView({super.key});

  @override
  _SupportViewState createState() => _SupportViewState();
}

class _SupportViewState extends ConsumerState<SupportView> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileFreelancerProvider);
    final listMessage = ref.watch(messageProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(profileFreelancerProvider.notifier);
        await ref.read(messageProvider.notifier).getMessage();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                LzColors.hex('11B0E6'),
                LzColors.hex('3265FF'),
              ],
              stops: const [0.0, 0.6],
            ),
          ),
          child: Stack(
            children: [
              Textr(
                'Messages',
                margin: Ei.only(t: 50, l: 25),
                style: Gfont.bold.white.fsize(25),
              ),
              Container(
                margin: Ei.only(t: 120),
                width: context.width,
                height: context.height,
                decoration: BoxDecoration(
                    color: LzColors.hex('F8F8FF'),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: context.width,
                          margin: const EdgeInsets.only(left: 25, right: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: LzColors.hex('E6E6E8'),
                          ),
                          child: Row(
                            children: [
                              Iconr(
                                Ti.search,
                                color: LzColors.hex('747474'),
                                alignment: Alignment.centerLeft,
                                margin: Ei.only(l: 20),
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      searchQuery = value.trim().toLowerCase();
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Search User',
                                    border: InputBorder.none,
                                  ),
                                ).margin(l: 10),
                              )
                            ],
                          ),
                        ),
                        profile.when(
                          data: (ProfileFreelancerModel profile) {
                            return listMessage.when(
                              data: (List<MessageModel> messages) {
                                var sortedMessages =
                                    List<MessageModel>.from(messages)
                                      ..sort((a, b) => b.id!.compareTo(a.id!));

                                var filteredMessages =
                                    sortedMessages.where((message) {
                                  var fullName =
                                      '${message.conversation.user2.firstName} ${message.conversation.user2.lastName}'
                                          .toLowerCase();
                                  return fullName.contains(searchQuery);
                                }).toList();

                                Map<int, List<MessageModel>> groupedMessages =
                                    {};

                                for (var message in filteredMessages) {
                                  var conversationId = message.conversation.id;

                                  if (!groupedMessages
                                      .containsKey(conversationId)) {
                                    groupedMessages[conversationId] = [];
                                  }

                                  groupedMessages[conversationId]!.add(message);
                                }

                                return filteredMessages.isNotEmpty
                                    ? Column(
                                        children: groupedMessages.entries
                                            .map((entry) => Column(
                                                  children: [
                                                    if (entry.value.isNotEmpty)
                                                      InkTouch(
                                                        onTap: () {
                                                          context
                                                              .lzPush(ChatPage(
                                                            initialMessages:
                                                                entry.value,
                                                            senderId:
                                                                profile.id!,
                                                            conversationId:
                                                                entry.key,
                                                          ));
                                                        },
                                                        child: SizedBox(
                                                          height: 80,
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Center(
                                                                child: entry
                                                                            .value
                                                                            .first
                                                                            .conversation
                                                                            .user2
                                                                            .profilePhoto !=
                                                                        null
                                                                    ? LzImage(
                                                                        'https://homecare.galkasoft.id/storage/${entry.value.first.conversation.user2.profilePhoto}',
                                                                        size:
                                                                            50,
                                                                        radius:
                                                                            50,
                                                                      )
                                                                    : Icon(
                                                                        Icons
                                                                            .person, // Ikon profil default
                                                                        size:
                                                                            50,
                                                                        color: LzColors.hex(
                                                                            '747474'),
                                                                      ),
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Textr(
                                                                          '${entry.value.first.conversation.user2.firstName} ${entry.value.first.conversation.user2.lastName}',
                                                                          style: Gfont.color(LzColors.hex('000000'))
                                                                              .bold
                                                                              .fsize(12),
                                                                          margin:
                                                                              Ei.only(l: 10),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      margin: Ei
                                                                          .only(
                                                                              l: 10),
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Text(
                                                                        entry
                                                                            .value
                                                                            .first
                                                                            .messageText,
                                                                        style: Gfont.color(LzColors.hex('7C7C7C'))
                                                                            .fsize(12),
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ))
                                            .toList(),
                                      ).margin(t: 20, l: 25, r: 25)
                                    : const Textr('Message is empty',
                                        style: TextStyle(fontSize: 16));
                              },
                              error: (error, _) {
                                return LzNoData(message: 'Oops! $error');
                              },
                              loading: () {
                                return LzLoader.bar(
                                    message: 'Loading Message...');
                              },
                            );
                          },
                          error: (error, _) {
                            return LzNoData(message: 'Oops! $error');
                          },
                          loading: () {
                            return LzLoader.bar(message: 'Loading Profile...');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
