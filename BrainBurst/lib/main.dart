import 'package:brainburst/models/branch.dart';
import 'package:brainburst/screens/index_page.dart';
import 'package:brainburst/screens/reward_pages/badge_earn.dart';
import 'package:brainburst/screens/reward_pages/correct_excellent_page.dart';
// import 'package:brainburst/screens/index_page.dart';
import 'package:flutter/material.dart';
import 'package:brainburst/screens/welcome_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    ChangeNotifierProvider<BranchProvider>(
      create: (context) => BranchProvider(),
      child: 
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brain Burst',

        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            },
          ),
        ),
        // home: const CorrectExcellent(), 
        home: const WelcomePage(),
        // home: const IndexPage(),
      ),
    );
  }
}
