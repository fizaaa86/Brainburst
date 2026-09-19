import 'package:brainburst/constants/api.dart';
import 'package:brainburst/constants/colors.dart';
import 'package:brainburst/screens/learning_page.dart';
import 'package:brainburst/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Clr.orchidPink,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Text(
                'PROFILE',
                style: GoogleFonts.poppins(
                  color: Clr.darkPurple,
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(
              Icons.person,
              size: 150,
              color: Clr.darkPurple,
            ),
            Text(
              "Username: ${Api.user}",
              style: GoogleFonts.inter(
                color: Clr.darkPurple,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              width: 392,
              height: 264,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF1EBEF), // Darker color
                    Color(0xFFC8A5AA), // Lighter color
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Progress',
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: _generatePieSections(watched),
                        borderData: FlBorderData(show: false),
                        startDegreeOffset: -90,
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 90),
              width: 392,
              height: 78,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF1EBEF), // Darker color
                    Color(0xFFE1BCC1), // Lighter color
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                  Api().logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Image.asset('assets/sign_out.png'),
                    ),
                    Text(
                      'Sign out',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> fetchData() async {
  final response =
  await http.get(Uri.parse('http://192.168.29.218:8000/welcome'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    print(data);
  } else {
    throw Exception('Failed to load data');
  }
}

List<PieChartSectionData> _generatePieSections(List<bool> watchedStatus) {
  int watchedCount = watchedStatus.where((status) => status).length;
  int unwatchedCount = watchedStatus.length - watchedCount;

  List<PieChartSectionData> sections = [];

  // Change the color of the watched section
  sections.add(PieChartSectionData(
    color: Colors.green, // Change this to the desired color
    value: watchedCount.toDouble(),
    title: 'Watched',
    radius: 15,
    titleStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xff010000),
    ),
  ));

  // Change the color of the unwatched section
  sections.add(PieChartSectionData(
    color: Colors.red, // Change this to the desired color
    value: unwatchedCount.toDouble(),
    title: 'Unwatched',
    radius: 15,
    titleStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xff050404),
    ),
  ));

  return sections;
}

