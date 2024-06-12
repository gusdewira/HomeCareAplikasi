import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazyui/lazyui.dart';

import '../../../routes/paths.dart';
import '../../../widgets/color_widget.dart';
import '../widgets/search_notification.dart';


class NotificationHome extends StatelessWidget {
  const NotificationHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        color3, 
        color4,
      ],
      stops: const [0.0, 0.6]
    ),
      ),
      child: ListView(
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
                          'Notification',
                          style: Gfont.white.bold.fsize(18),
                        ))),
              const SearchNotification(),
              Positioned(
                top: 210,
                left: 25,
                right: 25,
                child: Column(
                  crossAxisAlignment: Caa.start,
                  children: [
                    Text('27-09-2023', style: Gfont.color(LzColors.hex('747474')).fsize(13),),
                    InkTouch(
                      onTap: (){
                        context.push(Paths.clickNotification);
                      },
                      child: Container(
                        margin: Ei.only(t: 10),
                        width: context.width/1,
                        height: 70,
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
                                  child: const Icon(Ti.bell, size: 30, color: Colors.white,)),
                                  Column(
                                    crossAxisAlignment: Caa.start,
                                    children: [
                                      Text('Congratulations, your listing is now active.', style: Gfont.color(LzColors.hex('747474')).fsize(12),),
                                      InkTouch(
                                        onTap: (){
                                        },
                                        child: Text('Click here to see listing', style: Gfont.color(color1).fsize(12)))
                                    ],
                                  ).margin(t: 18, l: 10),
                                   Textr('17.18', style: Gfont.color(LzColors.hex('747474')).fsize(12), margin: Ei.only(l: 30),),
                              ],
                            ),
                      ),
                    ),
                    Container(
                      margin: Ei.only(t: 10),
                      width: context.width/1,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                            )
                          ]),
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
                                child: const Icon(Ti.bell, size: 30, color: Colors.white,)),
                                Textr('Welcome, don’t forget to complete your personal info',
                                width: 225,
                                margin: Ei.only(l: 10),
                                 style: Gfont.color(LzColors.hex('747474')).fsize(12),),
                                 Textr('17.18', style: Gfont.color(LzColors.hex('747474')).fsize(12), margin: Ei.only(l: 30),),
                            ],
                          ),
                    )
                  ],
                )
                ),

                Positioned(
                top: 420,
                left: 25,
                right: 25,
                child: Column(
                  crossAxisAlignment: Caa.start,
                  children: [
                    Text('27-09-2023', style: Gfont.color(LzColors.hex('747474')).fsize(13),),
                    Container(
                      margin: Ei.only(t: 10),
                      width: context.width/1,
                      height: 70,
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
                                child: const Icon(Ti.bell, size: 30, color: Colors.white,)),
                                Column(
                                  crossAxisAlignment: Caa.start,
                                  children: [
                                    Text('Congratulations, your listing is now active.', style: Gfont.color(LzColors.hex('747474')).fsize(12),),
                                    InkTouch(
                                      onTap: (){},
                                      child: Text('Click here to see listing', style: Gfont.color(LzColors.hex('0047E3')).fsize(12)))
                                  ],
                                ).margin(t: 18, l: 10),
                                 Textr('17.18', style: Gfont.color(LzColors.hex('747474')).fsize(12), margin: Ei.only(l: 30),),
                            ],
                          ),
                    ),
                    Container(
                      margin: Ei.only(t: 10),
                      width: context.width/1,
                      height: 70,
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
                                child: const Icon(Ti.bell, size: 30, color: Colors.white,)),
                                Textr('Welcome, don’t forget to complete your personal info',
                                width: 225,
                                margin: Ei.only(l: 10),
                                 style: Gfont.color(LzColors.hex('747474')).fsize(12),),
                                 Textr('17.18', style: Gfont.color(LzColors.hex('747474')).fsize(12), margin: Ei.only(l: 30),),
                            ],
                          ),
                    )
                  ],
                )
                )
            ],
          ),
        ],
      ),
    );
  }
}