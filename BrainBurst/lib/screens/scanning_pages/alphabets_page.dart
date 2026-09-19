import 'package:brainburst/constants/api.dart';
import 'package:brainburst/models/branch.dart';
import 'package:brainburst/screens/scanning_pages/scanning_index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AlphabetsPage extends StatelessWidget {
  const AlphabetsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: Center(
        child: Column(
          children: [
            const ScanningPageLogo(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 520,
              width: 340,
              child: GridView.count(
                crossAxisCount: 3,
                children: const [
                  AlphabetBox('അ',1),
                  AlphabetBox('ആ',2),
                  AlphabetBox('ഇ',3),
                  AlphabetBox('ഈ',4),
                  AlphabetBox('ഉ',5),
                  AlphabetBox('ഊ',6),
                  AlphabetBox('ഋ',7),
                  AlphabetBox('എ',8),
                  AlphabetBox('ഏ',9),
                  AlphabetBox('ഐ',10),
                  AlphabetBox('ഒ',11),
                  AlphabetBox('ഓ',12),
                  AlphabetBox('ഔ',13),
                  AlphabetBox('അം',14),
                  AlphabetBox('അഃ',15),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AlphabetBox extends StatelessWidget {
  final String data;
  final int num;
  const AlphabetBox(this.data, this.num ,{super.key});

  @override
  Widget build(BuildContext context) {
        final branchProvider = context.watch<BranchProvider>();

    return InkWell(
      onTap: () {
        branchProvider.changeBranchIndex(3); 
        chapterIdNum = num;
      },
      child: Container(
        width: 94,
        height: 84,
        margin: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: const Color(0xFFEBE8B1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 5,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Colors.black.withOpacity(0.20000000298023224),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
            child: Text(
          data,
          style: GoogleFonts.markoOne(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        )),
      ),
    );
  }
}
