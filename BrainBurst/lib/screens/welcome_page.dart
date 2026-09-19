import 'package:brainburst/constants/api.dart';
import 'package:brainburst/screens/index_page.dart';
import 'package:brainburst/screens/login_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 130),
                  width: 513,
                  height: 262,
                  child: Image.asset("assets/welcome_page_logo.png"),
                ),
                SizedBox(
                  width: 513,
                  height: 50,
                  child: Image.asset("assets/welcome_page_cap.png"),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 127,
                  ),
                  width: 300,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF1A524E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      // checkLogin(); 
                      // auth();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Api.logedIn ? const IndexPage() : const LoginPage() )));
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Koulen',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

