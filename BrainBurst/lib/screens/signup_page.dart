import 'package:brainburst/constants/api.dart';
import 'package:brainburst/screens/index_page.dart';
import 'package:brainburst/screens/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String username = '';
  String email = '';
  String password = '';
  bool seePassword = true;
  bool isValidEmail = true;

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
                SizedBox(
                  width: 513,
                  height: 312,
                  child: Image.asset('assets/login_page_image.png'),
                ),
                Expanded(
                  child: Container(
                    width: 393,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.47, -0.88),
                        end: Alignment(-0.47, 0.88),
                        colors: [Color(0xFFF999C7), Color(0x00F999C7)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 45),
                            child: const Text(
                              'Welcome Aboard !!!',
                              style: TextStyle(
                                color: Color(0xFF1A524E),
                                fontSize: 36,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            width: 344,
                            height: 55,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Color(0xCC1A524E)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                username = value;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  hintText: "Enter your username",
                                  hintStyle: TextStyle(
                                    color: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    height: 0,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: 344,
                            height: 55,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Color(0xCC1A524E)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                email = value;

                                setState(() {
                                  isValidEmail = EmailValidator.validate(email);
                                });
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  hintText: "Enter your Email",
                                  hintStyle: TextStyle(
                                    color: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    height: 0,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          isValidEmail
                              ? Container()
                              : const Padding(
                                  padding: EdgeInsets.only(left: 40),
                                  child: Row(
                                    children: [
                                      Icon(Icons.clear, color: Colors.red),
                                      Text("Email is not valid",
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: 344,
                            height: 55,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 2, color: Color(0xCC1A524E)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                password = value;
                              },
                              obscureText: seePassword,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock_open),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          seePassword = !seePassword;
                                        });
                                      },
                                      icon: const Icon(Icons.remove_red_eye)),
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(
                                    color: Colors.black
                                        .withOpacity(0.6499999761581421),
                                    fontSize: 15,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w300,
                                    height: 0,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 40, bottom: 20),
                            width: 344,
                            height: 63,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF1A524E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                await signUp({
                                  'username': username,
                                  'email': email,
                                  'password': password,
                                });
                                logIn({
                                  'username': username,
                                  'password': password
                                }).then((value) {
                                  // print(value);
                                  if (value == 'logged in') {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const IndexPage())));
                                  }
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    bottom: 15, top: 15, left: 0, right: 0),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const LoginPage())));
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Already have an account?',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 15,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w300,
                                      height: 0,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'Log In',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> signUp(Map<String, dynamic> data) async {
  var url = '${Api.baseUrl}register'; // Include 'http://' or 'https://'
  String body = json.encode(data);
  print(url);

  try {
    var response = await http.post(
      Uri.parse(url), // Use Uri.parse to create the Uri
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['Message'];
    } else {
      // Handle other status codes (e.g., 404, 500, etc.) if needed
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    // Handle exceptions (e.g., network errors)
    return 'Error: $e';
  }
}
