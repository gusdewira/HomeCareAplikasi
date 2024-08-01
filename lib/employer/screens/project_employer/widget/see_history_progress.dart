import 'package:flutter/material.dart';
import 'package:homecare_app/employer/providers/project_active_provider.dart';
import 'package:homecare_app/freelancer/data/models/project/history_progress_model.dart';
import 'package:homecare_app/freelancer/widgets/color_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class SeeHistoryProgressEmployer extends ConsumerWidget {
  final int id;
  const SeeHistoryProgressEmployer({super.key, required this.id});

@override
Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProgressProvider(id));
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                LzColors.hex('11B0E6'),
                LzColors.hex('3265FF'),
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
              width: context.width,
              height: context.height,
              decoration: BoxDecoration(
                  color: LzColors.hex('F8F8FF'),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
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
                  'History Progress',
                  style: Gfont.white.bold.fsize(18),
                ))),
            Column(
              children: [
                Container(
                    child: history.when(data: (HistoryProgressModel progress) {
                  return Container(
                    height: 160,
                    width: context.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2, color: Colors.black12)),
                    child: Column(
                      crossAxisAlignment: Caa.start,
                      children: [
                        Row(
                          crossAxisAlignment: Caa.start,
                          children: [
                            const LzImage(
                              'profile.jpg',
                              radius: 50,
                              size: 50,
                            ).margin(t: 10),
                            Column(
                              crossAxisAlignment: Caa.start,
                              children: [
                                Textr(
                                  progress.title!,
                                  style: Gfont.color(color1).fsize(12).bold,
                                  margin: Ei.only(b: 5),
                                  width: context.width / 2 - 10,
                                  maxLines: 2,
                                  overflow: Tof.ellipsis,
                                ),
                                Textr(
                                  progress.description!,
                                  margin: Ei.only(b: 10),
                                  style: Gfont.fs10,
                                  width: context.width / 2,
                                  overflow: Tof.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ).margin(l: 10)
                          ],
                        ).margin(l: 10, t: 10),
                        Container(
                          margin: Ei.only(l: 15, r: 15, t: 10),
                          height: 40,
                          width: context.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(width: 2, color: Colors.black12)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: Maa.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        child: Textr(
                                          progress.attachment!
                                              .split('/attachments/')[1],
                                          margin: Ei.only(l: 10),
                                          style: Gfont.fs13,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkTouch(
                                    onTap: () {},
                                    child: Container(
                                      margin: Ei.only(r: 15),
                                      padding: Ei.all(6),
                                      decoration: BoxDecoration(
                                          color: LzColors.hex('FFD700'),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Textr(
                                        'Download',
                                        style: Gfont.color(LzColors.hex('000000'))
                                            .fsize(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        ),
                      ],
                    ),
                  );
                }, error: (error, _) {
                  return LzNoData(message: 'Oops! $error');
                }, loading: () {
                  return LzLoader.bar(message: 'Loading...');
                }))
              ],
            ).margin(l: 25, r: 25, t: 150)
          ],
        ));
  }
}
