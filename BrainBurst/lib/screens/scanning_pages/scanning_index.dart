import 'package:brainburst/constants/colors.dart';
import 'package:brainburst/models/branch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ScanningIndex extends StatelessWidget {
  const ScanningIndex({super.key});

  @override
  Widget build(BuildContext context) {
    final branchProvider = context.watch<BranchProvider>();

    return Container(
     width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.39, 0.92),
          end: Alignment(-0.39, -0.92),
          colors: [Color(0xFFF7D5E5), Color(0x00FA99C8)],
        ),
      ),
      child: Column(
        children: [
          const ScanningPageLogo(),
          InkWell(
            onTap: () {
              branchProvider.changeBranchIndex(5);
            },
            child: ScanningIndexTile(
              fontsizewid: 24,
              icon: Image.asset('assets/scanning_page/tile1.png'),
              text: 'SCAN OBJECTS',
            ),
          ),
          InkWell(
            onTap: () {
              branchProvider.changeBranchIndex(4);
            },
            child: ScanningIndexTile(
              fontsizewid: 32,
              icon: Image.asset('assets/scanning_page/tile2.png'),
              text: 'LEARN',
            ),
          ),
          InkWell(
            onTap: () {
              branchProvider.changeBranchIndex(2);
            },
            child: ScanningIndexTile(
              fontsizewid: 32,
              icon: Container(
                width: 53,
                height: 55,
                decoration: const ShapeDecoration(
                  color: Color(0xFFFC81CB),
                  shape: OvalBorder(),
                ),
                child: const Icon(Icons.mic_none),
              ),
              text: 'SPEECH',
            ),
          ),
        ],
      ),
    );
  }
}

class ScanningPageLogo extends StatelessWidget {
  const ScanningPageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25, left: 30),
          width: 134,
          height: 100,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(75),
            ),
          ),
          child: Image.asset('assets/scanning_page/brainburst21.png'),
        ),
      ],
    );
  }
}

class ScanningIndexTile extends StatelessWidget {
  final String text;
  final Widget icon;
  final double fontsizewid;
  const ScanningIndexTile(
      {super.key,
      required this.icon,
      required this.text,
      required this.fontsizewid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(40),
      width: 306,
      height: 109,
      decoration: ShapeDecoration(
        color: Clr.lightCyan, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: icon,
          ),
          SizedBox(
            child: Text(
              text,
              style: GoogleFonts.markoOne(
                color: Clr.darkPurple,  
                fontSize: fontsizewid,
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
