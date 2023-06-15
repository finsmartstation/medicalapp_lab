import 'package:flutter/material.dart';
import 'package:medical_app_lab/screens/labRole/lab_dashboard.dart';
import 'package:medical_app_lab/utility/constants.dart';
import '../startScreen/get_started.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 // List<AccessModel>? accessModel = [];
  String isLogin = "0";
  Future GetLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      isLogin = prefs.getString('isLogin')!;
      access_token= prefs.getString('access_token');
      uid=prefs.getString('user_id');

      // print(prefs.getBool("isLogin"));
    });
  }

  bool ActiveConnection = false;
  String T = "";
  setInternet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Connectivity', ActiveConnection);
  }

  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          setInternet();
          T = "Turn off the data and repress again";
          print("Network Available");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        setInternet();
        T = "Turn On the data and repress again";
        print("Network  Not Available");
      });
    }
  }

  @override
  void initState() {
    CheckUserConnection();
    GetLogin();
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (isLogin == "0") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const GetStarted()),
        );
      } else if (isLogin == "lab") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LabDashboard()),
        );
      } 
      //   Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => isLogin ==true? Dashboard():GetStarted()
      //   ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(height: 80, width: 300, child: Image.asset(appLogo)),
        ),
      ),
    );
  }
}
