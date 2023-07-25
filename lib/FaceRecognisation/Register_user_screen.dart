// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:projectapp/ML/Recognition.dart';
// import 'package:projectapp/ML/Recognizer.dart';
// import 'package:projectapp/widgets/appbar%20copy.dart';
// import 'package:projectapp/widgets/appbar.dart';
// import 'package:projectapp/widgets/circularindicator.dart';
// import 'package:projectapp/widgets/dialogbox.dart';
// import 'package:projectapp/widgets/gradientbutton.dart';
// import 'package:projectapp/utils/colors.dart';
// import 'package:projectapp/widgets/gradientbuttonpro.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// import 'package:provider/provider.dart';
// import 'package:quickalert/quickalert.dart';
// import 'package:projectapp/FaceRecognisation/Register_user_screen.dart';
// import 'package:projectapp/FaceRecognisation/cropedFaceImage.dart';
// import 'package:projectapp/FaceRecognisation/Cropped_Provider.dart';
// import 'Cropped_Provider.dart';
// import 'package:image/image.dart' as img;
// import 'package:projectapp/Ml/Recognizer.dart';
// class Register_user_screen extends StatefulWidget {
//   const Register_user_screen({Key? key}) : super(key: key);

//   @override
//   State<Register_user_screen> createState() => _Register_user_screenState();
// }

// class _Register_user_screenState extends State<Register_user_screen> {
//   late FaceDetector faceDetector;
//   List<Face> faces = [];
//   File? image;
//   File? crpImage;
//   File? croppedImage;
//   var pick;
//   TextEditingController _controller = TextEditingController();
//   File? _image;
//   @override
//   void initState() {
//     super.initState();
//     final options = FaceDetectorOptions();
//     faceDetector = FaceDetector(options: options);
//   }

//   //This method uploads the image to firebase storage and returns the url of the image---------------------------------------------
//   final ImagePicker _picker = ImagePicker();

//   void choosimage() async {
//     final XFile? pickedfile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedfile != null) {
//       image = File(pickedfile.path);
//       setState(() {
//         _image = image;
//       });
//       doFacedetect();
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Image not selected')));
//     }
//   }

// //This method captures the image from the camera and returns the image----------------------------------------------------------
//   void capturesimage() async {
//     final XFile? pickedfile =
//         await _picker.pickImage(source: ImageSource.camera);
//     if (pickedfile != null) {
//       image = File(pickedfile.path);
//     }
//     setState(() {
//       _image = image;
//     });
//     doFacedetect();
//   }

// //This method detects the face in the image and checks if there is more than one face in the image---------------------------------
//   Future<void> doFacedetect() async {
//     InputImage inputImage = InputImage.fromFile(_image!);
//     final List<Face> detectedFaces =
//         await faceDetector.processImage(inputImage);
//     if (detectedFaces.length > 1) {
//       QuickAlert.show(
//         context: context,
//         animType: QuickAlertAnimType.scale,
//         type: QuickAlertType.warning,
//         text: 'There are ${detectedFaces.length} faces in the image',
//         title: 'Please upload a single face',
//         onConfirmBtnTap: Navigator.of(context).pop,
//       );
//     } else {
//       faces = detectedFaces;
//       performFacedetection();
//     }
//   }

// // This method crops the image and adds it to the stream-----------------------------------------------------------------------
//   Future<void> performFacedetection() async {
//     _image = await removerotation(_image!);
//     pick = await _image?.readAsBytes();
//     pick = await decodeImageFromList(pick!);
//     for (Face face in faces) {
//       num left = face.boundingBox!.left < 0 ? 0 : face.boundingBox!.left;
//       num top = face.boundingBox!.top < 0 ? 0 : face.boundingBox!.top;
//       num right = face.boundingBox!.right > pick.width
//           ? pick.width - 1
//           : face.boundingBox!.right;
//       num bottom = face.boundingBox!.bottom > pick.height
//           ? pick.height - 1
//           : face.boundingBox!.bottom;
//       num width = right - left;
//       num height = bottom - top;
//       croppedImage = await FlutterNativeImage.cropImage(
//         _image!.path,
//         top.toInt(),
//         left.toInt(),
//         width.toInt(),
//         height.toInt(),
//       );

//       // Add the croppedImage to the provider  when it's available
//       Provider.of<croppedprovider>(context, listen: false)
//           .setcroppedImage(croppedImage!);
//       Future.delayed(Duration(seconds: 1), () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CroppedFaceScreen(),
//           ),
//         );
//       });
//       img.Image? new_cropped_image =
//           img.decodeImage(croppedImage!.readAsBytesSync());
       
//     }
//   }

// //This function is used to remove the rotation of the image-----------------------------------------------------------------------
//   Future removerotation(File inputImage) async {
//     final img.Image? new_cropped_image =
//         img.decodeImage(inputImage.readAsBytesSync());
//     final img.Image orientedImage = img.bakeOrientation(new_cropped_image!);
//     return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
//   }

//   //From here the UI starts------------------------------------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: GradientAppBarFbpro(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           _image != null
//               ? CircleAvatar(
//                   radius: 76,
//                   backgroundImage: MemoryImage(_image!.readAsBytesSync()))
//               : Stack(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Colors.black,
//                       radius: 85,
//                       child: ClipOval(
//                         child: Image.network(
//                           "https://static.vecteezy.com/system/resources/thumbnails/000/581/100/small/1_aGVhZC0wMQ.jpg",
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: -6,
//                       left: 104,
//                       child: IconButton(
//                         color: Colors.white,
//                         onPressed: () {
//                           choosimage();
//                         },
//                         icon: Icon(Icons.add_a_photo),
//                       ),
//                     ),
//                   ],
//                 ),
//           SizedBox(height: 23),
//           Center(
//             child: GradientButtonFb1(
//               text: 'Capture Image',
//               onPressed: () {
//                 capturesimage();
//               },
//             ),
//           ),
//           // StreamBuilder to listen to croppedImage changes and show the dialog
//           // Positioned(
//           //   top: 59,
//           //   left: 0,
//           //   right: 0,
//           //   child: StreamBuilder(
//           //     stream: croppedImageStream,
//           //     builder: (context, snapshot) {
//           //       return snapshot.hasData
//           //           ? AlertDialog(
//           //               title: Center(
//           //                   child: Text(
//           //                 'AUTHENTICATED!',
//           //                 style: TextStyle(
//           //                     fontWeight: FontWeight.bold,
//           //                     fontStyle: FontStyle.italic),
//           //               )),
//           //               actionsOverflowAlignment: OverflowBarAlignment.start,
//           //               backgroundColor: Colors.white,
//           //               actions: [
//           //                 Center(
//           //                   child: Image.file(
//           //                     snapshot.data!,
//           //                     width: 152,
//           //                     height: 152,
//           //                     fit: BoxFit.cover,
//           //                   ),
//           //                 ),
//           //                 TextField(
//           //                   decoration: InputDecoration(
//           //                     hintText: 'Enter your name',
//           //                     hintStyle: TextStyle(
//           //                       color: Colors.black,
//           //                     ),
//           //                   ),
//           //                   textAlign: TextAlign.center,
//           //                   controller: _controller,
//           //                   showCursor: true,
//           //                 ),
//           //                 SizedBox(height: 23),
//           //                 Center(
//           //                   child: Row(
//           //                     mainAxisAlignment: MainAxisAlignment.center,
//           //                     crossAxisAlignment: CrossAxisAlignment.center,
//           //                     children: [
//           //                       Center(
//           //                         child: GradientButtonFbpro(
//           //                           text: 'Register',
//           //                           controller: _controller,
//           //                           onPressed: () {
//           //                             // doFacedetect();
//           //                             Navigator.pop(context);
//           //                           },
//           //                         ),
//           //                       ),
//           //                       SizedBox(width: 10),
//           //                     ],
//           //                   ),
//           //                 ),
//           //               ],
//           //             )
//           //           : SizedBox(); // Return an empty container if snapshot.data is null
//           //     },
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
// }
