import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app_lab/screens/labRole/lab_basicdetails.dart';
import 'package:medical_app_lab/screens/labRole/lab_dashboard.dart';
import 'package:medical_app_lab/utility/constants.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/auth_provider.dart';
import '../../providers/phone_provider.dart';
import '../../service/api_services.dart';
class OtpSection extends StatefulWidget {
  String phoneNum;
  String otp;
  OtpSection({Key? key, required this.phoneNum, required this.otp})
      : super(key: key);

  @override
  State<OtpSection> createState() => _OtpSectionState();
}

class _OtpSectionState extends State<OtpSection> {
  String? uName;
  String? email;
  String? profilePic;
  String? role;
  String? user_id;
  String? access_token;
  final OtpFieldController _pinController = OtpFieldController();
  Future setProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (uName!.isNotEmpty) {
      prefs.setString('userName', uName!);
    }
    if (email!.isNotEmpty) {
      prefs.setString('email', email!);
    }
    if (profilePic!.isNotEmpty) {
      prefs.setString('profilePicture', profilePic!);
    }
    prefs.setString('accessToken', access_token!);
    prefs.setString('userId', user_id!);
    print("profile set");
    print(prefs.getString("userId"));
    print(prefs.getString("accessToken"));
  }

  setUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', access_token!);
    prefs.setString('userId', user_id!);
    print("profile set");
    print(prefs.getString("userId"));
    print(prefs.getString("accessToken"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      List<String> a = widget.otp.split("");
      _pinController.setValue(a[0], 0);
      _pinController.setValue(a[1], 1);
      _pinController.setValue(a[2], 2);
      _pinController.setValue(a[3], 3);
      _pinController.setValue(a[4], 4);
      _pinController.setValue(a[5], 5);
      print("______________________");
      print(a);
      print("______________________");
    });

    print("otp");
    print(widget.otp);
    print("num");
    print(widget.phoneNum);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PhoneProvider, AuthProvider>(
        builder: (context, pValue, aValue, child) {
      String userId = aValue.u_id;
      String accessToken = aValue.access_token;
      return Scaffold(
        resizeToAvoidBottomInset: false,
       // backgroundColor: backgroundColor,
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            backgroundPlusImage(),
            const SizedBox(
              height: 20,
            ),
            verifyingNumTextWidget(),
            const SizedBox(
              height: 80,
            ),
            const Center(
                child: Text("Waiting to automatically detect an SMS send to")),
            Center(
              child: Row(
                children: [
                  const Spacer(),
                  Text("${widget.phoneNum}."),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Wrong number")),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Otpfiled(aValue, userId, accessToken, context, pValue),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Enter 6 -digits code",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const Spacer(),
            Row(
              children: [
                const SizedBox(
                  width: 60,
                ),
                backgroundPlusImage(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Divider(
                endIndent: 40,
                thickness: 1,
                indent: 40,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Spacer(),
                const Text("If you didn't receive code?"),
                TextButton(onPressed: () {}, child: const Text("Resend")),
                const Spacer()
              ],
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
  }

  Center Otpfiled(AuthProvider aValue, String userId, String accessToken,
      BuildContext context, PhoneProvider pValue) {
    return Center(
      child: OTPTextField(
          length: 6,
          width: 300,
          fieldWidth: 40,
          controller: _pinController,
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.box,
          style: const TextStyle(fontSize: 17),
          onChanged: (val) {
            Future.delayed(const Duration(seconds: 1), (() {
              print(val);
              print('changed');
              print(aValue.otp);
              print(_pinController);
              if (val == aValue.otp) {
                // _countDownController.pause();
                ApiService()
                    .verifyOTP(aValue.u_id, aValue.access_token, val)
                    .then((value) async {
                  // print(value.body);

                  if (value.statusCode == 200) {
                    var jsonData = jsonDecode(value.body)['data'];
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('user_id', jsonData['user_id']);
                    prefs.setString('access_token', jsonData['access_token']);

                    userId = jsonData['user_id'];
                    accessToken = jsonData['access_token'];
                    role = jsonData['user_type'];
                    setUserId();
                    print("user id");
                    print(aValue.u_id);
                    print(accessToken);
                    print("userId and token===");
                    print(userId);
                    print(accessToken);

                    print(jsonData['login_status']);
                    print(role);
                    
                      if (jsonData['login_status'] == "0") {
                        print("1234New");
                        pValue.isValid(false);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LabBasicDetails()));
                      }
                      if (jsonData['login_status'] == "1") {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("isLogin", "lab");
                        pValue.isValid(false);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LabDashboard()));
                      }
                    
                    // _countDownController.pause();
                  }
                  // print("USER: ==> ${}")
                });
              } else {
                // print("wrogggggggggggggggggggge");
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(
                //   content: Text(
                //     "Invalid Otp",
                //     style: TextStyle(color: Colors.white),
                //   ),
                //   backgroundColor: Colors.blue[800],
                //   elevation: 10,
                // ));
              }

              // print(_pinController.text);
              // print(a_value.u_id);
              // print(a_value.access_token);
            }));
          },
          onCompleted: (val) {}),
    );
  }

  Center verifyingNumTextWidget() {
    return const Center(
        child: Text(
      "Verifiying your number",
      style: TextStyle(color: Colors.black, fontSize: 18),
    ));
  }

  Row backgroundPlusImage() {
    return Row(
      children: [
        SizedBox(
          height: 50,
          child: Image.asset(
            elems,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
// import 'dart:async';
// import 'dart:convert';
// import 'dart:ffi';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/material.dart';
// import 'package:fss_medical_app/providers/auth_provider.dart';
// import 'package:fss_medical_app/providers/phone_provider.dart';
// import 'package:fss_medical_app/providers/doctorRol/user_provider.dart';
// import 'package:fss_medical_app/screens/authScreen/auth_screen.dart';
// import 'package:fss_medical_app/screens/doctorRole/dashboard/dashboard.dart';
// import 'package:fss_medical_app/screens/newUserProfile/user_profile.dart';
// import 'package:fss_medical_app/screens/patientRole/dashboard/dashboardScreen.dart';
// import 'package:fss_medical_app/screens/patientRole/patient_basic_details.dart';
// import 'package:fss_medical_app/service/api_services.dart';
// import 'package:provider/provider.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../providers/patientRole/petientdetailsGetProvider.dart';

// class OtpSection extends StatefulWidget with CodeAutoFill {
//   OtpSection({Key? key}) : super(key: key);

//   @override
//   State<OtpSection> createState() => _OtpSectionState();

//   @override
//   void codeUpdated() {
//     // TODO: implement codeUpdated
//     print("Updated code ${code}");
//     print('Code Updated');
//   }
// }

// class _OtpSectionState extends State<OtpSection> {
//   static const int maxSeconds = 30;
//   int seconds = maxSeconds;
//   Bool? loginStatus;
//   Bool? userData;
//   final TextEditingController _pinController = TextEditingController();
//   final CountDownController _countDownController = CountDownController();

//   bool isOver = false;
//   SetLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isLogin', true);
//   }

//   String? uName;
//   String? email;
//   var user_id;
//   var access_token;
//   String? profilePic;
//   String? role;
//   Future setProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('userName', uName!);
//     prefs.setString('email', email!);
//     prefs.setString('profilePicture', profilePic!);
//     prefs.setString('accessToken', access_token);
//     prefs.setString('userId', user_id);
//     print("profile set");
//     print(prefs.getString("userId"));
//     print(prefs.getString("accessToken"));
//   }

//   setUserId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('accessToken', access_token);
//     prefs.setString('userId', user_id);
//     print("profile set");
//     print(prefs.getString("userId"));
//     print(prefs.getString("accessToken"));
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _listenOTP();
//   }

//   void _listenOTP() async {
//     await SmsAutoFill().listenForCode;
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     SmsAutoFill().unregisterListener();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PhoneProvider>(
//       builder: (context, p_value, child) {
//         return Consumer<AuthProvider>(
//           builder: (context, a_value, child) {
//             user_id = a_value.u_id;
//             access_token = a_value.access_token;
//             return Container(
//               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'OTP sent to ${p_value.phone}',
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             p_value.isValid(false);
//                           });
//                         },
//                         icon: Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Spacer(),
//                       if (isOver)
//                         InkWell(
//                           onTap: () {
//                             ApiService().resendOTP(a_value.u_id);
//                             setState(() {
//                               isOver = false;
//                             });
//                           },
//                           child: Text('Resend OTP'),
//                         )
//                       else
//                         CircularCountDownTimer(
//                             width: MediaQuery.of(context).size.width / 8,
//                             height: MediaQuery.of(context).size.height / 8,
//                             duration: 20,
//                             fillColor: Colors.purple,
//                             ringColor: Colors.amber,
//                             controller: _countDownController,
//                             textStyle: const TextStyle(
//                               fontSize: 18.0,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textFormat: CountdownTextFormat.S,
//                             isReverse: true,
//                             isReverseAnimation: true,
//                             onComplete: () => setState(() => isOver = true)),

//                       // buildTimer(),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   PinFieldAutoFill(
//                     codeLength: 6,
//                     onCodeChanged: (val) {
//                       // print('changed');
//                       if (_pinController.text.length == 6){
//                          _countDownController.pause();
//                           ApiService()
//                           .verifyOTP(
//                               a_value.u_id, a_value.access_token, a_value.otp)
//                           .then((value) async {
//                         // print(value.body);

//                         if (value.statusCode == 200) {
//                           var jsonData = jsonDecode(value.body)['data'];
//                           print("user id");
//                           print(a_value.u_id);
//                           print(access_token);
//                           user_id = jsonData['user_id'];
//                           access_token = jsonData['access_token'];
//                           setUserId();
//                           print("userId and token===");
//                           print(user_id);
//                           print(access_token);
//                           role = jsonData['user_type'];
//                           print(jsonData['login_status']);
//                           print(role);
//                           if (role == "Doctor") {
//                             if (jsonData['login_status'] == "0") {
//                               print("1234New");
//                               p_value.isValid(false);
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => ProfilePage()));
//                             } else {
//                               SharedPreferences prefs =
//                                   await SharedPreferences.getInstance();
//                               prefs.setString("isLogin", "doctor");
//                               print("1234EXIST");
//                               p_value.isValid(false);
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => Dashboard()));
//                             }
//                           } else if (role == "Patient") {
//                             setState(() {
//                               context
//                                   .read<GetpetientDetails>()
//                                   .fetchdata(user_id, access_token);
//                             });

//                             if (jsonData['login_status'] == "0") {
//                               print("1234New");
//                               p_value.isValid(false);
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => PatientBasicDetails()));
//                             }
//                             if (jsonData['login_status'] == "1") {
//                               SharedPreferences prefs =
//                                   await SharedPreferences.getInstance();
//                               prefs.setString("isLogin", "patient");
//                               p_value.isValid(false);
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => DashboardPatient()));
//                             }
//                           }

//                           //   }  else {
//                           //     print("1234EXIST");
//                           //     p_value.isValid(false);
//                           //     Navigator.pushReplacement(
//                           //         context,
//                           //         MaterialPageRoute(
//                           //             builder: (_) => Dashboard()));
//                           //   }
//                           // }

//                           // ApiService()
//                           //     .getUserDetails(
//                           //         a_value.u_id, a_value.access_token)
//                           //     .then((value) {
//                           //   var jsonUser = jsonDecode(value.body)['data'];
//                           //   print("sdsdsdsdsdsdsdsd: ${jsonUser.length}");
//                           //   print(jsonData);
//                           //   user_id=jsonData['user_id'];
//                           //   access_token=jsonData['access_token'];
//                           //   setUserId();
//                           //   print("userId and token===");
//                           //   print(user_id);
//                           //   print(access_token);
//                           //   print(jsonData['login_status']);
//                           //   var uProvider = Provider.of<UserProvider>(context,
//                           //       listen: false);
//                           //   if (jsonData['login_status'] == 0) {
//                           //     loginStatus != false;
//                           //   } else {
//                           //     loginStatus != true;
//                           //   }
//                           //   if (jsonUser.length == 0) {
//                           //     userData != false;
//                           //   } else {
//                           //     userData != true;
//                           //     SetLogin();
//                           //     uName = jsonUser['username'];
//                           //   email = jsonUser['email'];
//                           //   profilePic = jsonUser['profile_pic'];
//                           //   setProfile();
//                           //   print("userId and token===");
//                           //   print(user_id);
//                           //   print(access_token);
//                           //   }
//                           //   if (jsonUser.length > 0) {
//                           //     uProvider.getUserDetails(
//                           //         jsonUser['access_id'],
//                           //         jsonUser['username'],
//                           //         jsonUser['email'],
//                           //         jsonUser['profile_pic'],
//                           //         loginStatus,
//                           //         userData);
//                           //   }
//                           //   print('AASASSAS: ${jsonUser}');
//                           //   if (jsonData['login_status'] == "0" &&
//                           //       jsonUser.length == 0) {
//                           //     print("1234New");
//                           //     p_value.isValid(false);
//                           //     Navigator.pushReplacement(
//                           //         context,
//                           //         MaterialPageRoute(
//                           //             builder: (_) => ProfilePage()));
//                           //   } else if (jsonData["login_status"] == "0" &&
//                           //       jsonUser.length > 0) {
//                           //     print("1234EXISTNEW");
//                           //     p_value.isValid(false);
//                           //     Navigator.pushReplacement(
//                           //         context,
//                           //         MaterialPageRoute(
//                           //             builder: (_) => Dashboard()));

//                           //   } else {
//                           //     print("1234EXIST");
//                           //     p_value.isValid(false);
//                           //     Navigator.pushReplacement(
//                           //         context,
//                           //         MaterialPageRoute(
//                           //             builder: (_) => Dashboard()));
//                           //   }
//                           // });
//                         }
//                         // print("USER: ==> ${}")
//                       });
//                       }
                       
//                       // print(_pinController.text);
//                       // print(a_value.u_id);
//                       // print(a_value.access_token);
                     
//                     },
//                     controller: _pinController,
//                     textInputAction: _pinController.text.length == 6
//                         ? TextInputAction.done
//                         : TextInputAction.none,
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
