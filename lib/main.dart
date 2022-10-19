import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ImagePicker imagePicker;
  File? _image;
  var image;
  //TODO declare detector

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
    //TODO initialize detector

  }

  @override
  void dispose() {
    super.dispose();

  }

  //TODO capture image using camera
  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if(pickedFile != null) {
      _image = File(pickedFile.path);
      doObjectDetection();
    }
  }

  //TODO choose image using gallery
  _imgFromGallery() async {
    XFile? pickedFile =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doObjectDetection();
    }
  }

  //TODO face detection code here
  doObjectDetection() async {
    setState(() {
      _image;
    });
    //drawRectanglesAroundObjects();
  }

  // //TODO draw rectangles
  // drawRectanglesAroundObjects() async {
  //   image = await _image?.readAsBytes();
  //   image = await decodeImageFromList(image);
  //   setState(() {
  //     image;
  //     objects;
  //     result;
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg.jpg'), fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                const SizedBox(
                  width: 100,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Stack(children: <Widget>[
                    Center(
                      child: ElevatedButton(
                        onPressed: _imgFromGallery,
                        onLongPress: _imgFromCamera,
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child:
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: _image != null
                              ? Image.file(
                            _image!,
                            width: 350,
                            height: 350,
                            fit: BoxFit.fill,
                          )
                              : Container(
                            width: 350,
                            height: 350,
                            color: Colors.pinkAccent,
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 100,
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 350,
                        //   height: 350,
                        //   margin: const EdgeInsets.only(
                        //     top: 45,
                        //   ),
                        //   child: image != null
                        //       ? Center(
                        //     child: FittedBox(
                        //       child: SizedBox(
                        //         width: image.width.toDouble(),
                        //         height: image.width.toDouble(),
                        //         child: CustomPaint(
                        //           painter: ObjectPainter(
                        //               objectList: objects, imageFile: image),
                        //         ),
                        //       ),
                        //     ),
                        //   )
                        //       : Container(
                        //     color: Colors.pinkAccent,
                        //     width: 350,
                        //     height: 350,
                        //     child: const Icon(
                        //       Icons.camera_alt,
                        //       color: Colors.black,size: 53
                        //       ,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          )),
    );
  }
}

// class ObjectPainter extends CustomPainter {
//   List<DetectedObject> objectList;
//   dynamic imageFile;
//   ObjectPainter({required this.objectList, @required this.imageFile});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (imageFile != null) {
//       canvas.drawImage(imageFile, Offset.zero, Paint());
//     }
//     Paint p = Paint();
//     p.color = Colors.red;
//     p.style = PaintingStyle.stroke;
//     p.strokeWidth = 4;
//
//     for (DetectedObject rectangle in objectList) {
//       canvas.drawRect(rectangle.boundingBox, p);
//       var list = rectangle.labels;
//       for(Label label in list){
//         print("${label.text}   ${label.confidence.toStringAsFixed(2)}");
//         TextSpan span = TextSpan(text: label.text,style: const TextStyle(fontSize: 25,color: Colors.blue));
//         TextPainter tp = TextPainter(text: span, textAlign: TextAlign.left,textDirection: TextDirection.ltr);
//         tp.layout();
//         tp.paint(canvas, Offset(rectangle.boundingBox.left,rectangle.boundingBox.top));
//         break;
//       }
//     }
//
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
