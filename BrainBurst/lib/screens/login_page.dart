import 'dart:convert';

import 'package:brainburst/constants/api.dart';
import 'package:brainburst/screens/index_page.dart';
import 'package:brainburst/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import 'package:django_rest_framework_client/django_rest_framework_client.dart';
// import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  var seePassword = true;

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
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 45),
                            child: const Text(
                              'Welcome !!!',
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
                              onPressed: () {
                                // print(api.login(username, password));
            
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
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("wrong username or password"),
                                      ),
                                    );
                                  }
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    bottom: 15, top: 15, left: 120, right: 120),
                                child: Text(
                                  'Log In',
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
                                          const SignupPage())));
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don’t have an account',
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
                                    text: 'Sign Up',
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

Future<String> logIn(Map<String, dynamic> data) async {
  var url = '${Api.baseUrl}login'; // Include 'http://' or 'https://'
  String body = json.encode(data);
  print(data);
  print(url);
  // print(Api.user);

  try {
    var response = await http.post(
      Uri.parse(url), // Use Uri.parse to create the Uri
      body: body,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // print(response.statusCode);
    // print(body);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // print(jsonResponse['response']);
      // Api.token = jsonResponse['token'] ;
      Api().tokenchange(jsonResponse['token']);
      print(Api.token);

      auth();
      return jsonResponse['response'];
    } else {
      // Handle other status codes (e.g., 404, 500, etc.) if needed
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    // Handle exceptions (e.g., network errors)
    return 'Error: $e';
  }
}

void auth() async {
  final url = Uri.parse("${Api.baseUrl}welcome");
  final response =
      await http.get(url, headers: {'Authorization': 'Token ${Api.token}'});
  print(response.body);
  print("auth");
  var a = jsonDecode(response.body);
  Api().login(a['user'],a["userid"]);
  // return response;
}
