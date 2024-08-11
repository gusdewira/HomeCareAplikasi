import 'package:flutter/material.dart';
import 'package:homecare_app/freelancer/providers/setting/profile_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/profile_freelancer_model.dart';
import '../../../widgets/color_widget.dart';

class AddMorePortofolio extends ConsumerWidget {
  final ProfileFreelancerModel? data;
  const AddMorePortofolio({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(editProfilChangeNotifier.notifier);

    if (data != null) {
      notifier.fillForm(data!);
    }

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Ti.chevronLeft,
                  size: 30,
                ),
              ).margin(l: 15, t: 60),
              Expanded(
                child: Text(
                  'Portofolio',
                  style: Gfont.fs18.bold,
                ).margin(t: 60, l: 5),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: Ei.only(
                  l: 25,
                  r: 25,
                  t: 120,
                ),
                width: context.width,
                height: 40,
                decoration: BoxDecoration(
                  color: LzColors.hex('E6E6E8'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Textr(
                      'Add More Portofolio',
                      alignment: Alignment.centerLeft,
                      padding: Ei.all(10),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: color1,
                      ),
                      onPressed: () {
                        ref
                            .read(editProfilChangeNotifier.notifier)
                            .pickPortfolio(context, data!.id);
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: data?.portofolioAttachments == null ||
                        data!.portofolioAttachments!.isEmpty
                    ? const Center(
                        child: Text('Portfolio is empty'),
                      )
                    : ListView.builder(
                        padding: Ei.only(l: 25, r: 25, t: 20),
                        itemCount: data!.portofolioAttachments!.length,
                        itemBuilder: (context, index) {
                          final portfolio = data!.portofolioAttachments![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(portfolio.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        radius: 20,
        color: color1,
        text: 'Add Image',
        textColor: Colors.white,
        onTap: (state) {},
      ).theme1().margin(b: 50, l: 15, r: 15),
    );
  }
}
