import 'package:brainburst/screens/index_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:brainburst/models/branch.dart';

class BadgeEarn extends StatelessWidget {
  const BadgeEarn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 393,
          height: 852,
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.39, 0.92),
              end: Alignment(-0.39, -0.92),
              colors: [Color(0xFFF7D5E5), Color(0xFFFA99C8)],
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 287,
                height: 208,
                child: Column(
                  children: [
                    Text(
                      'EXCELLENT\n',
                      style: GoogleFonts.irishGrover(
                        color: const Color(0xFFDC0D7D),
                        fontSize: 48,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'YOU EARNED A BADGE!',
                      style: GoogleFonts.irishGrover(
                        color: const Color(0xFF0E0E0E),
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/earn_badge/p1.png'),
              ),
              const NextButton()
            ],
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    final branchProvider = context.watch<BranchProvider>();

    return InkWell(
      onTap: () {
        // branchProvider.changeBranchIndex(0);
       Future.delayed(Duration.zero, () => branchProvider.changeBranchIndex(0));
      },
      child: Container(
        width: 224,
        height: 66,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 132, 249, 163),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            'Next',
            style: GoogleFonts.irishGrover(
                fontSize: 36, color: const Color.fromARGB(255, 43, 108, 77)),
          ),
        ),
      ),
    );
  }
}
