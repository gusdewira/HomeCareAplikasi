import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class ListMessages extends StatelessWidget {
  const ListMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkTouch(
          onTap: () {},
          child: SizedBox(
            height: 80,
            width: double.infinity, // Mengisi lebar dengan lebar layar penuh
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Menjaga elemen di atas
              children: [
                const Center(
                  child: LzImage(
                    'profile1.jpg',
                    size: 50,
                    radius: 50,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Textr(
                            'Deangga',
                            style: Gfont.color(LzColors.hex('000000'))
                                .bold
                                .fsize(12),
                            margin: Ei.only(l: 10),
                          ),
                          Textr(
                            '29/09/2023',
                            style:
                                Gfont.color(LzColors.hex('000000')).fsize(10),
                          ),
                        ],
                      ),
                      Container(
                        margin: Ei.only(l: 10),
                        width: double
                            .infinity, // Mengisi lebar dengan lebar layar penuh
                        child: Text(
                          'eu consequat ac felis donec et odio pellentesque diam volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae',
                          style: Gfont.color(LzColors.hex('7C7C7C')).fsize(12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          width: double.infinity, // Mengisi lebar dengan lebar layar penuh
          color: LzColors.hex('E9E9E9'),
        ),
        InkTouch(
          onTap: () {},
          child: SizedBox(
            height: 80,
            width: double.infinity, // Mengisi lebar dengan lebar layar penuh
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Menjaga elemen di atas
              children: [
                const Center(
                  child: LzImage(
                    'profile2.jpg',
                    size: 50,
                    radius: 50,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Textr('Gandhi',
                              style: Gfont.color(LzColors.hex('000000'))
                                  .bold
                                  .fsize(12),
                              margin: Ei.only(l: 10)),
                          Textr(
                            '29/09/2023',
                            style:
                                Gfont.color(LzColors.hex('000000')).fsize(10),
                          ),
                        ],
                      ),
                      Container(
                        margin: Ei.only(l: 10),
                        width: double
                            .infinity, // Mengisi lebar dengan lebar layar penuh
                        child: Text(
                          'eu consequat ac felis donec et odio pellentesque diam volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae',
                          style: Gfont.color(LzColors.hex('7C7C7C')).fsize(12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: Ei.only(t: 5),
          height: 1,
          width: double.infinity, // Mengisi lebar dengan lebar layar penuh
          color: LzColors.hex('E9E9E9'),
        ),
        InkTouch(
          onTap: () {},
          child: SizedBox(
            height: 80,
            width: double.infinity, // Mengisi lebar dengan lebar layar penuh
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Menjaga elemen di atas
              children: [
                const Center(
                  child: LzImage(
                    'profile3.jpg',
                    size: 50,
                    radius: 50,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Textr('Istriwhy',
                              style: Gfont.color(LzColors.hex('000000'))
                                  .bold
                                  .fsize(12),
                              margin: Ei.only(l: 10)),
                          Textr(
                            '29/09/2023',
                            style:
                                Gfont.color(LzColors.hex('000000')).fsize(10),
                          ),
                        ],
                      ),
                      Container(
                        margin: Ei.only(l: 10),
                        width: double
                            .infinity, // Mengisi lebar dengan lebar layar penuh
                        child: Text(
                          'eu consequat ac felis donec et odio pellentesque diam volutpat commodo sed egestas egestas fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis aliquam malesuada bibendum arcu vitae',
                          style: Gfont.color(LzColors.hex('7C7C7C')).fsize(12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: Ei.only(t: 5),
          height: 1,
          width: double.infinity, // Mengisi lebar dengan lebar layar penuh
          color: LzColors.hex('E9E9E9'),
        ),
      ],
    ).margin(t: 20, l: 25, r: 25);
  }
}
