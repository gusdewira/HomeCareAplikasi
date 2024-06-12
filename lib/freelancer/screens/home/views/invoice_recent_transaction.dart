import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class InvoiceRecentTransaction extends StatelessWidget {
  const InvoiceRecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return LzListView(
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(onPressed: (){
               Navigator.of(context).pop();
              }, icon: const Icon(Ti.chevronLeft, size: 30,)),
            ).margin(l: 15, b: 50),
            Icon(
              Ti.circleCheckFilled,
              color: LzColors.hex('3A6A1D'),
              size: 40,
            ),
            Text(
              'Deposit successful!',
              style: Gfont.color(LzColors.hex('3A6A1D')).bold.fsize(18),
            ).margin(t: 5),
            Text('This transaction has been successfully processed, ',
                style: Gfont.color(LzColors.hex('B9B9B9'))).margin(l: 25, r: 25),
            Text('and the balance has been credited to your account.',
                style: Gfont.color(LzColors.hex('B9B9B9'))).margin(l: 25, r: 25),
            Column(
              crossAxisAlignment: Caa.start,
              children: [
                Row(
                  mainAxisAlignment: Maa.spaceBetween,
                  children: [
                    Text('Invoice Number', style: Gfont.color(LzColors.hex('000000')).bold,),
                    Text('112345 78900000', style: Gfont.color(LzColors.hex('000000')).bold)
                  ],
                ).margin(t: 15),
                Text('Due: 30/09/2023', style: Gfont.color(LzColors.hex('747474'))).margin(t: 15),
                Row(
                  mainAxisAlignment: Maa.spaceBetween,
                  children: [
                    Text('Account Number', style: Gfont.color(LzColors.hex('747474'))),
                    Text('1124 5555 **** ****', style: Gfont.color(LzColors.hex('000000')))
                  ],
                ).margin(t: 15),
                Container(
                  margin: Ei.only(t: 20),
                  width: context.width,
                  height: 20,
                  child: Text('--------------------------------------------------------------------------', 
                  style: Gfont.color(LzColors.hex('000000'))),
                ),
                Text('Detail Payment', style: Gfont.color(LzColors.hex('000000'))).margin(t: 20),
                Row(
                  mainAxisAlignment: Maa.spaceBetween,
                  children: [
                    Text('Payment Method', style: Gfont.color(LzColors.hex('747474'))),
                    Text('System', style: Gfont.color(LzColors.hex('000000')))
                  ],
                ).margin(t: 20),
                Row(
                  mainAxisAlignment: Maa.spaceBetween,
                  children: [
                    Text('Project Name', style: Gfont.color(LzColors.hex('747474'))),
                    Textr('CyberShield Security Enhancement', style: Gfont.color(LzColors.hex('000000')),
                    width: 150,
                    textAlign: Ta.center,)
                  ],
                ).margin(t: 15),
                Textr('Total',
                style: Gfont.color(LzColors.hex('747474')).fsize(20),
                alignment: Alignment.center, 
                margin: Ei.only(t: 70),
                ),
                Textr('Rp200.000', 
                style: Gfont.color(LzColors.hex('000000')).fsize(25),
                alignment: Alignment.center,),
                Container(
                  margin: Ei.only(t: 10),
                  width: context.width,
                  height: 20,
                  child: Text('--------------------------------------------------------------------------', 
                  style: Gfont.color(LzColors.hex('000000'))),
                ),
              ],
            ).margin(t: 50, l: 25, r: 25)
            
          ],
        ).margin(t: 50),
      ],
    );
  }
}