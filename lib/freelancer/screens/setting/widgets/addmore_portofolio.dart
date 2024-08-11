import 'package:flutter/material.dart';
import 'package:homecare_app/freelancer/providers/setting/edit_profile_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/profile_freelancer_model.dart';
import '../../../widgets/color_widget.dart';

class AddMorePortofolio extends ConsumerStatefulWidget {
  final ProfileFreelancerModel? data;
  const AddMorePortofolio({super.key, this.data});

  @override
  _AddMorePortofolioState createState() => _AddMorePortofolioState();
}

class _AddMorePortofolioState extends ConsumerState<AddMorePortofolio> {
  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      final notifier = ref.read(editProfilChangeNotifier.notifier);
      notifier.fillForm(widget.data!);
    }
  }

  void _showDeleteConfirmation(BuildContext context, int index, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text(
              'Are you sure you want to delete this portfolio item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.data?.portofolioAttachments?.removeAt(index);
                });
                ref.read(editProfilChangeNotifier.notifier).delete(id);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                            .pickImage(context, widget.data!.id!);
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
                child: widget.data?.portofolioAttachments == null ||
                        widget.data!.portofolioAttachments!.isEmpty
                    ? const Center(
                        child: Text('Portfolio is empty'),
                      )
                    : ListView.builder(
                        padding: Ei.only(l: 25, r: 25, t: 20),
                        itemCount: widget.data!.portofolioAttachments!.length,
                        itemBuilder: (context, index) {
                          final portfolio =
                              widget.data!.portofolioAttachments![index];
                          return GestureDetector(
                            onLongPress: () {
                              _showDeleteConfirmation(
                                  context, index, portfolio.id);
                            },
                            child: Container(
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
