import 'dart:io';
import 'package:brainburst/constants/api.dart';
import 'package:brainburst/constants/colors.dart';
import 'package:brainburst/models/branch.dart';
import 'package:brainburst/models/text_processs.dart';
import 'package:brainburst/screens/learning_page.dart';
import 'package:brainburst/screens/reward_pages/correct_excellent_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UplaodingPage extends StatefulWidget {
  const UplaodingPage({Key? key}) : super(key: key);

  @override
  State<UplaodingPage> createState() => _UplaodingPageState();
}

class _UplaodingPageState extends State<UplaodingPage> {
  String recognizedTextOut = '';
  File? imageFile;
  TextRecognizer _textDetector = GoogleMlKit.vision.textRecognizer();

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      // Perform text recognition when the image is selected
      await _recognizeText();
    }
  }

  // Future<void> _recognizeText() async {
  //   if (imageFile == null) return;

  //   final inputImage = InputImage.fromFile(imageFile!);
  //   final textRecognizer = GoogleMlKit.vision.textRecognizer();
  //   final text = await textRecognizer.processImage(inputImage);

  //   String recognizedText = '';

  //   for (TextBlock block in text.blocks) {
  //     for (TextLine line in block.lines) {
  //       // Check if the line contains Malayalam characters
  //       if (line.text.contains(RegExp(r'[ം-ൿ]'))) {
  //         recognizedText += line.text + '\n';
  //       }
  //       // recognizedText += line.text + '\n';
  //     }
  //   }

  //   // Handle the recognized text here, you can update the UI with the text
  //   print("Recognized Text: $recognizedText");
  //   setState(() {
  //     recognizedTextOut = recognizedText;
  //   });

  //   // Clean up resources
  //   textRecognizer.close();
  // }

  Future<void> _recognizeText() async {
    if (imageFile == null) return;

    final inputImage = InputImage.fromFile(imageFile!);

    String recognizedText = '';
  }

  @override
  Widget build(BuildContext context) {
    final branchProvider = context.watch<BranchProvider>();

    return Container(
      height: 852,
      width: 393,
      decoration: const BoxDecoration(color: Clr.lightBlue),
      child: Column(
        children: [
          Container(
            width: 358,
            height: 252,
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
            decoration: ShapeDecoration(
              color: const Color(0xB2FAFAFA),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0,
                  color: Color(0xFF9E9E9E),
                ),
                borderRadius: BorderRadius.circular(8.66),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _getImage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 16),
                    decoration: ShapeDecoration(
                      color: const Color(0x191A524E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Icon(Icons.upload,
                        color: Color.fromARGB(255, 151, 150, 150)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 52,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: _getImage,
                          child: const Text(
                            'Click here',
                            style: TextStyle(
                              color: Color(0xFF136DC7),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 0.12,
                            ),
                          ),
                        ),
                        const Text(
                          ' to upload the അക്ഷരം',
                          style: TextStyle(
                            color: Color(0xFF1A524E),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 0.12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 344,
            height: 231,
            margin: const EdgeInsets.only(top: 50),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Stack(
              children: [
                if (imageFile != null) Image.file(imageFile!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    imageFile == null
                        ? Container()
                        : InkWell(
                            onTap: () {
                              setState(() {
                                imageFile = null;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: const ShapeDecoration(
                                  color: Colors.red, shape: CircleBorder()),
                              child:
                                  const Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          FutureBuilder(
              future: TextProcess()
                  .textProcess(imageFile ?? File('assets/badges/badge1.png')),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    recognizedTextOut = snapshot.data.toString();
                  }

                  return Column(
                    children: [
                      const SizedBox(
                        height: 100,
                        child: Text(
                          " ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          // softWrap:
                          //     true,
                          // overflow: TextOverflow.clip,
                        ),
                      ),
                      
                      ElevatedButton(
                        onPressed: () {
                          print(recognizedTextOut+chapterIdNum.toString());  
                           
                          if (recognizedTextOut != chapterIdNum.toString()) {
                            fetchVideo().then((chapters) {
                              // Use the list of video URLs here
                              print(chapters[chapterIdNum - 1]['link']);
                              print(chapters[chapterIdNum - 1]['id']);

                              videoUrl = chapters[chapterIdNum - 1]['link'];
                              videoIndex = chapters[chapterIdNum - 1]['id'];
                              uprogress({
                                'video_id': chapterIdNum,
                                'user_id': Api.userId
                              });
                              branchProvider.changeBranchIndex(1);
                            }).catchError((error) {
                              // Handle error here
                              print('Error fetching video URLs: $error');
                            });
                          } else if (recognizedTextOut ==
                              chapterIdNum.toString()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CorrectExcellent()));
                          }
                        },
                        child: const Text("Check Answer"),
                      )
                    ],
                  );
                } else {
                  return const SizedBox(
                      height: 80,
                      width: 80,
                      child: SizedBox(
                          height: 80,
                          width: 80,
                          child: CircularProgressIndicator()));
                }
              }),
          // SizedBox(
          //   height: 100,
          //   child: Text(
          //     'Recognized Text:\n$recognizedTextOut',
          //     style: const TextStyle(
          //       color: Colors.black,
          //       fontSize: 16,
          //     ),
          //     // softWrap:
          //     //     true,
          //     // overflow: TextOverflow.clip,
          //   ),
          // )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textDetector.close();
    super.dispose();
  }
}
