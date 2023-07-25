// import 'package:flutter/material.dart';
// import 'package:projectapp/FaceRecognisation/Cropped_Provider.dart';
// import 'package:projectapp/FaceRecognisation/cropedFaceImage.dart';
// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:projectapp/widgets/appbar%20copy.dart';
// import 'package:projectapp/widgets/appbar.dart';
// import 'package:projectapp/widgets/dialogbox.dart';
// import 'package:projectapp/widgets/gradientbutton.dart';
// import 'package:projectapp/utils/colors.dart';
// import 'package:projectapp/widgets/gradientbuttonpro.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:provider/provider.dart';
// import 'package:quickalert/quickalert.dart';
// import 'package:projectapp/FaceRecognisation/cropedFaceImage.dart'; 
// class CroppedFaceScreen extends StatefulWidget {
//   const CroppedFaceScreen({super.key});
//   @override
//   State<CroppedFaceScreen> createState() => _CroppedFaceScreenState();
// }

// class _CroppedFaceScreenState extends State<CroppedFaceScreen> {
//   TextEditingController _controller = TextEditingController();
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:GradientAppBarFbpro(),
//       body:Consumer<croppedprovider>(
//         builder: (context, croppedprovider, child) {
//           if (croppedprovider.croppedimage == null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 backgroundColor: Colors.red,
//                 content: Text('No image loaded'),
//               ));
//           }
//           return Center(
//             child:Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Card(
//                   color:backgroundColor,
//                   child:Column(
//                     children: [
//                       Text('Register your Face!!',style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 21,color: Colors.white),),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                         child: Container(
//                           width: 150,
//                           height: 150,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               image: FileImage(croppedprovider.croppedimage!),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           ),
//                       ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextField(
//                           cursorColor: const Color.fromARGB(255, 216, 216, 216),
//                           enabled: true,
//                           textAlign: TextAlign.center,
//                           controller: _controller,
//                           decoration: InputDecoration(
//                             hintText: 'Enter your name',
//                             border: OutlineInputBorder(
                              
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(color: const Color.fromARGB(255, 251, 251, 251)),
//                             ),
//                           filled: true,
//                           fillColor: Colors.white
//                           ),
//                         ),
//                         SizedBox(
//                           height: 16,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           child: GradientButtonFbpro(text: 'Register', onPressed: (){}, controller: _controller),
//                         )
                        
//                     ],
//                   )
//                 )
//               ],
//             )
//           );
//         },
//       )
//       );
//   }
// }