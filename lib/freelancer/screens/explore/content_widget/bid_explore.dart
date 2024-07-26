import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../../data/models/setting/project_freelancer_model.dart';
import '../../../providers/explore/bid_project_provider.dart';
import '../../../providers/explore/project_freelancer_provider.dart';
import '../../../widgets/color_widget.dart';

class BidExplore extends ConsumerWidget {
  final ProjectFreelancerModel? data;

  const BidExplore({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(bidProvider.notifier);
    final forms = notifier.forms;

    if (!data.hasNull) {
      forms.fill(data!.toJson());
    }

    return RefreshIndicator(
    onRefresh: () async {
      await ref.read(projectFreelancer.notifier).getProjectFreelancer();
    },
      child: Scaffold(
        body: Container(
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
        child: LzFormList(
          cleanOnFilled: true,
          style: LzFormStyle(
            activeColor: LzColors.dark,
            inputBorderColor: Colors.black26,
            type: FormType.topInner,
          ),
          padding: Ei.zero,
          children: [
            Stack(
              children: [
                Container(
                  margin: Ei.only(t: 120),
                  width: context.width,
                  height: context.height,
                  decoration: BoxDecoration(
                      color: color2,
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
                      'Make an offer ${data!.id!}',
                      style: Gfont.white.bold.fsize(18),
                    ))),
                Column(
                  crossAxisAlignment: Caa.start,
                  children: [
                    Text(
                      '${data!.title}',
                      style: Gfont.color(LzColors.hex('000000')).bold,
                    ).margin(b: 15),
                    SizedBox(
                      width: context.width,
                      child: Row(
                        mainAxisAlignment: Maa.spaceBetween,
                        children: [
                          Text(
                            'Start Date: ${DateFormat('dd/MM/yyyy').format(data!.startDate!)}',
                            style: Gfont.fs12.bold,
                          ),
                          Text(
                            'End date : ${DateFormat('dd/MM/yyyy').format(data!.endDate!)}',
                            style: Gfont.fs12.bold,
                          )
                        ],
                      ).margin(b: 20),
                    ),

                    Container(
                      width: context.width,
                      height: 1,
                      color: Colors.black54,
                    ),

                    LzForm.input(
                      label: 'Bid Amount',
                      labelStyle: LzFormLabelStyle(color: color1),
                      hint: 'Input Bid Amount',
                      model: forms['offer_amount'],
                    ).margin(t: 20),
                    LzForm.input(
                      label: 'Estimated Duration',
                      labelStyle: LzFormLabelStyle(color: color1),
                      hint: 'Input Estimated Duration',
                      model: forms['estimated_duration'],
                    ),
                    LzForm.input(
                      label: 'Reason',
                      labelStyle: LzFormLabelStyle(color: color1),
                      hint: 'Input Reason',
                      model: forms['offer_reason'],
                    ),
                  ],
                ).margin(t: 140, l: 25, r: 25)
              ],
            ),
          ],
        ),
      ),
        bottomNavigationBar: LzButton(
          radius: 20,
          color: color1,
          textColor: Colors.white,
          text: 'Bid Project',
          onTap: (state) async {
            notifier.postbid(context, data!.id!);
            // forms['project_id'] = data!.id as FormModel;
            print(forms);
          },
        ).theme1().margin(b: 30),
      ),
    );
  }
}
