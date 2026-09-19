import 'package:brainburst/screens/reward_pages/badge_earn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CorrectExcellent extends StatefulWidget {
  const CorrectExcellent({Key? key}) : super(key: key);

  @override
  _CorrectExcellentState createState() => _CorrectExcellentState();
}

class _CorrectExcellentState extends State<CorrectExcellent> {
  bool _isImageVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isImageVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 393,
          height: 852,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Color.fromARGB(225, 223, 228, 228),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 287,
                height: 208,
                child: Column(
                  children: [
                    Text(
                      'WELL DONE!\n',
                      style: GoogleFonts.irishGrover(
                        color: const Color(0xFFDC0D7D),
                        fontSize: 48,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Text(
                    //   'YOU EARNED A BADGE!',
                    //   style: GoogleFonts.irishGrover(
                    //     color: const Color(0xFF0E0E0E),
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: _isImageVisible ? 150 : 0,
                child: Transform.translate(
                  offset: Offset(0.0, _isImageVisible ? 0.0 : 150.0),
                  child: Image.asset(
                    'assets/earn_badge/p2.png',
                    height: 150,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              NextButton()
            ],
          ),
        ),
      ),
    );
  }
}
