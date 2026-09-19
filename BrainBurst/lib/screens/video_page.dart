import 'package:brainburst/constants/colors.dart';
import 'package:brainburst/models/branch.dart';
import 'package:brainburst/screens/learning_page.dart';
import 'package:brainburst/screens/reward_pages/badge_earn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player_with_controls/video_player_with_controls.dart';

class VideoPage extends StatelessWidget {
  int index;
  String videoUrl;
  VideoPage({super.key, required this.index, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    final branchProvider = context.watch<BranchProvider>();

    return Container(
      // padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Clr.lightBlue,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'പാഠം-$index',
                  style: const TextStyle(
                    color: Color(0xFFA10A77),
                    fontSize: 48,
                    fontFamily: 'Marcellus',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.48,
                  ),
                ),
              ),
              // const Image(image: Svg('assets/video_page/circle.svg')),
              // Text(videoUrl),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 150),
            width: 394,
            height: 200,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: VideoPlayerWithControls(
              videoUrl: videoUrl,
            ),
          ),
        ],
      ),
    );
  }
}
