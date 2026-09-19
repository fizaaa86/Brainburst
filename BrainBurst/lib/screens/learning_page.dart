import 'package:brainburst/constants/api.dart';
import 'package:brainburst/constants/colors.dart';
import 'package:brainburst/models/branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String videoUrl = '';
int videoIndex = 0;

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Clr.lightBlue ,
        ),
       
      child: const Center(
        child: Column(

          children: [
            LearningPageLogo(),
            LearningPageImage(),
            LearningPageTitle(),
            LearningPageContent(),
          ],
        ),
      ),
    );
  }
}

class LearningPageLogo extends StatelessWidget {
  const LearningPageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 45,
            height: 40,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(75),
              ),
            ),
            child: Image.asset(
              'assets/learning_page/app_bar_logo.png',
            ),
          ),
        ),
      ],
    );
  }
}

class LearningPageImage extends StatelessWidget {
  const LearningPageImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(20),
      width: 365,
      height: 148,
      decoration: ShapeDecoration(
        color: const Color(0xFF29968E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 17),
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(3.10),
              child: const Image(image: Svg('assets/learning_page/Group3.svg')),
            ),
          ),
          const Image(
            image: Svg(
              'assets/learning_page/Group6.svg',
              size: Size(48, 60),
            ),
          ),
          const Image(
            image: Svg(
              'assets/learning_page/Group5.svg',
              size: Size(125, 135),
            ),
          ),
        ],
      ),
    );
  }
}

class LearningPageTitle extends StatelessWidget {
  const LearningPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: const Text(
              'Course Detail',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 70),
            width: 113,
            height: 26,
            decoration: ShapeDecoration(
              color: const Color(0xFF60E5AE),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.alarm,
                  color: Colors.white,
                  size: 13,
                ),
                Text(
                  '3 hours, 20 min',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LearningPageContentTile extends StatelessWidget {
  final int index;
  final bool played;
  const LearningPageContentTile(
      {super.key, required this.index, required this.played});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: 332,
      height: 56,
      decoration: ShapeDecoration(
        color: const Color(0xFF60E5AF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16),
            width: 30,
            height: 30,
            decoration: ShapeDecoration(
              color: played ? const Color(0xFF1A524E) : const Color(0xFFD9F0E6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            child: Center(
              child: Image(
                image: played
                    ? const Svg('assets/learning_page/play.svg')
                    : const Svg('assets/learning_page/play2.svg'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            width: 235,
            child: Text(
              'പാഠം- $index',
              style: TextStyle(
                color: played ? Colors.white : Colors.black,
                fontSize: 32,
                fontFamily: 'Marko One',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<bool> watched = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];

class LearningPageContent extends StatefulWidget {
  const LearningPageContent({super.key});

  @override
  State<LearningPageContent> createState() => _LearningPageContentState();
}

class _LearningPageContentState extends State<LearningPageContent> {
  // List<bool> watched = [
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false
  //   ];
  @override
  Widget build(BuildContext context) {
    final branchProvider = context.watch<BranchProvider>();
    List<Map<String, dynamic>> progresses;

    
    print('watched $watched');
    setState(() {
      fetchProgress().then((progress) {
        progresses = progress;
        print(' value ${progresses[2]['watched']}');
        // watched = progresses[2]['watched']==true;
        for (int i = 0; i < progresses.length; i++) {
          print(' value ${progresses[i]['watched']}');
          watched[i] = (progresses[i]['watched']);
        }
        print('watched after $watched');
      });
    
    });

    return Container(
      padding: const EdgeInsets.all(20),
      width: 367,
      height: 483,
      decoration: ShapeDecoration(
        color: Clr.airForceBlue,  
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: ListView(
        children: [
          for (int i = 0; i < 15; i++)
            InkWell(
              onTap: () {
                fetchVideo().then((chapters) {
                  // Use the list of video URLs here
                  print(chapters[i]['link']);
                  print(chapters[i]['id']);

                  videoUrl = chapters[i]['link'];
                  videoIndex = chapters[i]['id'];
                  uprogress({'video_id': i+1, 'user_id': Api.userId});  
                  branchProvider.changeBranchIndex(1);
                }).catchError((error) {
                  // Handle error here
                  print('Error fetching video URLs: $error');
                });
              },
              child: LearningPageContentTile(index: i + 1, played: watched[i]), 
            ),
        ],
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> fetchVideo() async {
  String url = '${Api.baseUrl}videos';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = response.body;
    List<Map<String, dynamic>> chapters =
        json.decode(data).cast<Map<String, dynamic>>();

    return chapters;
  } else {
    print('Request failed with status: ${response.statusCode}');
    // You might want to throw an exception here or handle the error in some way
    return []; // Return an empty list in case of failure
  }
}

Future<List<Map<String, dynamic>>> fetchProgress() async {
  String url = '${Api.baseUrl}progress?user_id=${Api.userId}';
  final response = await http.get(Uri.parse(url));
  print(url);
  if (response.statusCode == 200) {
    final data = response.body;
    List<Map<String, dynamic>> progress =
        json.decode(data).cast<Map<String, dynamic>>();
    // print(progress);
    return progress;
  } else {
    print('Request failed with status: ${response.statusCode}');
    // You might want to throw an exception here or handle the error in some way
    return []; // Return an empty list in case of failure
  }
}

Future<String> uprogress(Map<String, dynamic> data) async {
  var url = '${Api.baseUrl}uprogress'; // Include 'http://' or 'https://'
  String body = json.encode(data);
  print(url);

  try {
    var response = await http.post(
      Uri.parse(url), // Use Uri.parse to create the Uri
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['Message'];
    } else {
      // Handle other status codes (e.g., 404, 500, etc.) if needed
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    // Handle exceptions (e.g., network errors)
    return 'Error: $e';
  }
}
