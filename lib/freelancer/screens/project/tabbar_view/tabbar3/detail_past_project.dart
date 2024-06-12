import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class DetailPastProject extends StatelessWidget {
  const DetailPastProject({super.key});

  @override
  Widget build(BuildContext context) {
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
                    'Make an offer',
                    style: Gfont.white.bold.fsize(18),
                  ))),
              Column(
                crossAxisAlignment: Caa.start,
                children: [
                  Textr(
                    'Mobile App Development',
                    width: context.width / 2 + 20,
                    maxLines: 1,
                    style: Gfont.color(LzColors.hex('000000')).bold,
                  ),
                  Textr(
                    'Client : Angga Dwi Pastika',
                    margin: Ei.only(b: 10, t: 10),
                    width: context.width / 2 + 20,
                    maxLines: 1,
                    style: Gfont.color(LzColors.hex('000000')).bold.fsize(12),
                  ),
                  SizedBox(
                    width: context.width,
                    child: Row(
                      mainAxisAlignment: Maa.spaceBetween,
                      children: [
                        Textr(
                          'Start date : 23-12-2023',
                          width: context.width/2-30,
                          style: Gfont.fs12.bold,
                        ),
                        Expanded(
                          child: Textr(
                            'End date : 23-12-2023',
                            width: context.width/2,
                            style: Gfont.fs12.bold,
                          ),
                        )
                      ],
                    ).margin(b: 10),
                  ),
                  SizedBox(
                    width: context.width,
                    child: Row(
                      mainAxisAlignment: Maa.spaceBetween,
                      children: [
                        Textr(
                          'Hired date: 12-02-2023',
                          width: context.width/2-30,
                          style: Gfont.fs12.bold,
                        ),
                        Expanded(
                          child: Textr(
                            'Fixed rate: 1200k',
                            width: context.width/2,
                            style: Gfont.fs12.bold,
                          ),
                        )
                      ],
                    ).margin(b: 10),
                  ),
                  Container(
                    width: context.width,
                    height: 1,
                    color: Colors.black12,
                  ),
                  Text('Project Description',style: Gfont.color(LzColors.hex('000000')).fsize(15),).margin(t: 10),
                  Text('The Innovative Website Redesign project involves revamping our current website to enhance user experience, incorporate modern design elements, and optimize performance. The redesigned website will be a key component of our digital presence, catering to our diverse user base and reflecting our commitment to innovation.',
                  style: Gfont.color(LzColors.hex('595959')).fsize(12),
                  maxLines: 6,
                  overflow: Tof.ellipsis,
                  ).margin(t: 5)
                  
                ],
              ).margin(t: 140, l: 25, r: 25)
            ],
          ),
        ],
      ),
    );
  }
}
