class Api {
  static const String ip = '192.168.17.185';
  static const String baseUrl = 'http://$ip:8000/';  
  static var token = "";         
  static List<Map<String, dynamic>> chapters = []; 
  tokenchange(String newtoken) {
    token = newtoken;
  }   
  static String user= "";
  static String userId="1";
  static bool logedIn = false;
  login(String newuser,String newuserid) {
    user = newuser;
    userId=newuserid;
    logedIn = true;
    print("logged in");
    print(userId);
  }
  logout() {
    user = "";
    userId='';
    token = "";
    logedIn = false;
    print("logged out");
  }
  // getChapters(List<Map<String, dynamic>> chapters) {
  //   this.chapters = chapters;
  // }

}
  int chapterIdNum = 0;



// import 'package:http/http.dart' as http;

// class Api {
//   static const String baseUrl = 'http://192.168.1.81:8000/';
//   static var token = "";

//   tokenchange(String newtoken) {
//     token = newtoken;
//   }

  
// }

