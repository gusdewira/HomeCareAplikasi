import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../providers/setting/profile_provider.dart';
import '../../../widgets/color_widget.dart';
import '../widgets/list_message_supp.dart';
import '../widgets/search_widget_support.dart';

class SupportView extends ConsumerWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: ()async{
        ref.read(profileFreelancerProvider.notifier);
      },
      child: Scaffold(
        // Pindahkan properti decoration ke dalam Scaffold
        backgroundColor: Colors.transparent, // Atur latar belakang menjadi transparan
        extendBodyBehindAppBar: true, // Izinkan latar belakang di belakang AppBar
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
                      const SearchSupport().margin(l: 25, r: 25), 
                      const ListMessages()
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          margin: Ei.only(r: 25, b: 25),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: color1,
            child: const Icon(
              Ti.plus,
              size: 30,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
  }

