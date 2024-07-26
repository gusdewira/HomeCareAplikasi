
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/setting/profile_freelancer_model.dart';
import '../../../providers/setting/edit_profile_provider.dart';
import '../../../widgets/color_widget.dart';



class AddMorePortofolio extends ConsumerWidget {
  final ProfileFreelancerModel? data;
  const AddMorePortofolio({Key? key,this.data}) : super(key: key);

  
  @override
  Widget build(BuildContext context,WidgetRef ref) {

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
                  )).margin(l: 15, t: 60),
              Expanded(
                  child: Text(
                'Portofolio',
                style: Gfont.fs18.bold,
              ).margin(t: 60, l: 5))
            ],
          ),
          Column(
            children: [
              Container(
                margin: Ei.only(l: 25, r: 25, t: 120,),
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
                      style: TextButton.styleFrom(backgroundColor: color1,),
                      onPressed: (){
                        
                        ref.read(editProfilChangeNotifier.notifier).pickImage(context,data!.id);
                      },
                    child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),)
                  ],
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
        onTap: (state) {
        },
        
      ).theme1().margin(b: 50, l: 15, r: 15),
    );
  }
}




// class AddMorePortofolio extends StatefulWidget {
//   const AddMorePortofolio({super.key});

//   @override
//   State<AddMorePortofolio> createState() => _AddMorePortofolioState();
// }

// class _AddMorePortofolioState extends State<AddMorePortofolio> {
//   File? image;

//   Future getImage() async {
//     final ImagePicker picker = ImagePicker();
//     // Pick an image.
//     final XFile? portofolio =
//         await picker.pickImage(source: ImageSource.gallery);
//     image = File(portofolio!.path);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Row(
//             children: [
//               IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: const Icon(
//                     Ti.chevronLeft,
//                     size: 30,
//                   )).margin(l: 15, t: 60),
//               Expanded(
//                   child: Text(
//                 'Portofolio',
//                 style: Gfont.fs18.bold,
//               ).margin(t: 60, l: 5))
//             ],
//           ),
//           Column(
//             children: [
//               Container(
//                 margin: Ei.only(l: 25, r: 25, t: 120,),
//                 width: context.width,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: LzColors.hex('E6E6E8'),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Textr(
//                       'Add More Portofolio',
//                       alignment: Alignment.centerLeft,
//                       padding: Ei.all(10),
//                     ),
//                     TextButton(
//                       style: TextButton.styleFrom(backgroundColor: color1,),
//                       onPressed: (){
//                         ref
//                       },
//                     child: Icon(
//                           Icons.add,
//                           color: Colors.white,
//                         ),)
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20,),
//               image != null
//                   ? Container(
//                     margin: Ei.only(l: 25, r: 25),
//                       height: 300,
//                       width: context.width,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: black, width: 3)
//                       ),
//                       child: Image.file(
//                         image!,
//                         fit: BoxFit.cover,
//                       ))
//                   : Container()
//             ],
//           ),
//         ],
//       ),
//       bottomNavigationBar: LzButton(
//         radius: 20,
//         color: color1,
//         text: 'Add Image',
//         textColor: Colors.white,
//         onTap: (state) {
//         },
        
//       ).theme1().margin(b: 50, l: 15, r: 15),
//     );
//   }
// }
