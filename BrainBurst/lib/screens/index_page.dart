import 'package:brainburst/models/branch.dart';
import 'package:brainburst/screens/gaming_page.dart';
import 'package:brainburst/screens/learning_page.dart';
import 'package:brainburst/screens/login_page.dart';
import 'package:brainburst/screens/profile_page.dart';
import 'package:brainburst/screens/scanning_pages/camera_page.dart';
import 'package:brainburst/screens/scanning_pages/scanning_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const LearningPage(),
    const ScanningIndex(),
    const GamingPage(),
    const ProfilePage(),
  ];

  final List<String> _iconPaths = [
    'assets/BottomNavigation/bn1.png',
    'assets/BottomNavigation/bn2.png',
    'assets/BottomNavigation/bn3.png',
    'assets/BottomNavigation/bn4.png',
  ];

  @override
  Widget build(BuildContext context) {
    final branchProvider = context.watch<BranchProvider>();
    final branchIndex = branchProvider.branchIndex;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        branchProvider.changeBranchIndex(0);
      },
      child: Scaffold(
        body: branchIndex == 0
            ? SingleChildScrollView(
                child: _widgetOptions.elementAt(_selectedIndex))
            : branchProvider.getBranchWidget(),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            for (int i = 0; i < _widgetOptions.length; i++)
              BottomNavigationBarItem(
                icon: Image.asset(
                  _iconPaths[i],
                  width: 24,
                  height: 24,
                ),
                label: '_________',
              ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            decoration: TextDecoration.underline,
            decorationThickness: 8,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            branchProvider.changeBranchIndex(0);
          },
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
