import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homecare_app/freelancer/routes/paths.dart';
import 'package:homecare_app/freelancer/widgets/color_widget.dart';
import 'package:lazyui/lazyui.dart';

class Tabbar2ProjectEmployer extends StatelessWidget {
  const Tabbar2ProjectEmployer({super.key});

  @override
  Widget build(BuildContext context) {
    void _showEndContractDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: [
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                title:  Icon(Ti.alertTriangle, size: 55, color: Colors.red,),
                content: Text(
                  textAlign: Ta.center,
                  'If you complete this project, the system balance will be transferred to the freelancer.', style: Gfont.fs18,),
                actions: [
                  Row(
                    mainAxisAlignment: Maa.center,
                    children: [
                      InkTouch(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 90,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: LzColors.hex('0047E3')
                          ),
                          child: Textr(
                            alignment: Alignment.center,
                            'End', style: Gfont.white,),
                        ),
                      ),
                      SizedBox(width: 20,),
                       InkTouch(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 90,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.red, width: 2),
                      ),
                      child: Textr(alignment: Alignment.center,
                        'Cancel', style: Gfont.red,),
                    ),
                  )
                    ],
                  ).margin(b: 20)
                  
                ],
              ),
              Positioned(
                top: 290,
                right: 55,
                child: InkTouch(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Ti.x, color: black, size: 30,)))
            ],
          );
        },
      );
    }

    return Column(
      children: [
        Container(
          padding: Ei.only(l: 20, r: 20, t: 10),
          margin: Ei.only(l: 25, r: 25, b: 20, t: 20),
          height: 300,
          width: context.width / 1,
          decoration: BoxDecoration(
              color: LzColors.hex('FFFFFF'),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                )
              ]),
          child: Column(
            mainAxisSize: Mas.min,
            crossAxisAlignment: Caa.start,
            children: [
              Row(
                children: [
                  const LzImage(
                    'profile.jpg',
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
                            children: [
                              Textr('Ayu Istri',
                                  width: 150,
                                  overflow: Tof.ellipsis,
                                  style: Gfont.color(LzColors.hex('001380'))),
                              Textr('Web Development',
                                  overflow: Tof.ellipsis,
                                  width: 150,
                                  style: Gfont.color(LzColors.hex('B9B9B9'))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text('Hired date : 23 April - 10 November 2023').margin(t: 10),
              Text('Salary 2800K'),
              Container(
                margin: Ei.only(t: 8, b: 8),
                width: context.width,
                height: 1,
                color: Colors.grey,
              ),
              Textr(
                width: context.width,
                'Mobile App Development',
                style: Gfont.color(LzColors.hex('001380')),
                maxLines: 1,
                overflow: Tof.ellipsis,
              ),
              Text(
                'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over ',
                maxLines: 4,
                overflow: Tof.ellipsis,
              ),
              SizedBox(
                width: context.width,
                child: Row(
                  children: [
                    InkTouch(
                      onTap: () {
                        context.push(Paths.seeHistoryProgressEmployer);
                      },
                      child: Container(
                        height: 30,
                        width: 130,
                        decoration: BoxDecoration(
                          color: LzColors.hex('0047E3'),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Textr(
                          alignment: Alignment.center,
                          'See history Progress',
                          style: Gfont.color(LzColors.hex('ffffff')).fsize(12),
                        ),
                      ),
                    ),
                    InkTouch(
                      onTap: () {
                        _showEndContractDialog(context);
                      },
                      child: Container(
                        margin: Ei.only(l: 10),
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: Maa.center,
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Textr(
                              alignment: Alignment.center,
                              'End Contract',
                              style: Gfont.red.fsize(12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    InkTouch(
                      onTap: () {},
                      child: Icon(
                        Ti.message,
                        size: 30,
                        color: LzColors.hex('0047E3'),
                      ),
                    )
                  ],
                ).margin(t: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
