import 'package:brainburst/screens/reward_pages/badge_earn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TryAgain extends StatelessWidget {
  const TryAgain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 393,
          height: 852,
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment(0.39, 0.92),
            //   end: Alignment(-0.39, -0.92),
            //   colors: [Color(0xFFF7D5E5), Color(0xFFFA99C8)],
            // ),
            color: Color.fromARGB(225, 223, 228, 228) 
          ),
          child: Column(
            children: [
              SizedBox(
                width: 287,
                height: 208,
                child: Column(
                  children: [
                    Text(
                      'OOPS !!\n',
                      style: GoogleFonts.irishGrover(
                        color: const Color(0xFFDC0D7D),
                        fontSize: 48,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'TRY AGAIN',
                      style: GoogleFonts.irishGrover(
                        color: const Color(0xFF0E0E0E),
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                      ), 
                    ),
                  ],
                ), 
              ),
              // Row(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/earn_badge/p2.png'),
              ),
              const NextButton()
            ],
          ),
        ),
      ),
    );
  }
}