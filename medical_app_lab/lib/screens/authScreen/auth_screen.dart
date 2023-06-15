import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:medical_app_lab/screens/authScreen/otp_section.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../providers/auth_provider.dart';
import '../../providers/phone_provider.dart';
import '../../service/api_services.dart';
import '../../utility/constants.dart';

class InputMobileNumScreen extends StatefulWidget {
  const InputMobileNumScreen({super.key});

  @override
  State<InputMobileNumScreen> createState() => _InputMobileNumScreenState();
}

class _InputMobileNumScreenState extends State<InputMobileNumScreen> {
  String _phone = '';
  final phoneController = TextEditingController();
  String? appSignature;
  String? otpCode;
  bool isOver = false;
  bool isOverr = false;
  bool isLoading = false;
  String? aToken;
  String? uId;

  @override
  Widget build(BuildContext context) {
    return Consumer2<PhoneProvider, AuthProvider>(
      builder: (context, pValue, aValue, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE6E6E6),
          body: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              phoneNumberTextAndImageSection(),
              const SizedBox(
                height: 30,
              ),
              NumberTextFiled(pValue),
              const Spacer(),
              SendButton(pValue, context),
              const SizedBox(
                height: 30,
              ),
              Text(
                "MEDICEAPP will verify ",
                style: TextStyle(color: Colors.grey[600], fontSize: 15),
              ),
              Text(
                "your phone number ",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }

  SizedBox SendButton(PhoneProvider pValue, BuildContext context) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () async {
            if (pValue.phone.length > 12 && pValue.phone.length < 14) {
              appSignature = await SmsAutoFill().getAppSignature;
              setState(() {
                pValue.isValid(true);
                isLoading = true;
                isOver = false;
                ApiService()
                    .registerUser(pValue.countryCode, _phone, pValue.type,
                        '7', appSignature.toString())//'7'=>id for Lab
                    .then((value) async {
                  print("_________________");
                  print(value.body);
                  var jsonVal = jsonDecode(value.body);
                  print("json val===$jsonVal");
                  if (jsonVal['status'] == false) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Message"),
                        content: Text(jsonVal['message']),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              color: Colors.blue,
                              padding: const EdgeInsets.all(15),
                              child: const Text(
                                "okay",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OtpSection(
                              otp: jsonVal['data']['otp'],
                              phoneNum: _phone,
                            )));
                  }
                  String otp = jsonVal['data']['otp'];
                  print("___________________");
                  print(otp);
                  print("___________________");
                  var aProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  aProvider.getDetails(
                      jsonVal['data']['user_id'].toString(),
                      jsonVal['data']['otp'].toString(),
                      jsonVal['data']['access_token'].toString());
                  aToken = jsonVal['data']['access_token'].toString();
                  uId = jsonVal['data']['user_id'].toString();
                  print("token and id");
                  print(aToken);
                  print(uId);
                  SmsAutoFill().listenForCode;
                });
              });
            }
          },
          child: Text(
            "SEND",
            style: TextStyle(color: Colors.grey[600]),
          )),
    );
  }

  Row NumberTextFiled(PhoneProvider pValue) {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          width: 350,
          child: IntlPhoneField(
              controller: phoneController,
              style: const TextStyle(color: Colors.black),
              dropdownTextStyle: const TextStyle(color: Colors.black),
              dropdownIcon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hoverColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) async {
                if (phone.number.length == 10) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
                print(phone.completeNumber);
                _phone = phone.number;
                print(phone.countryCode.substring(1));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("phoneNum", _phone);
                print(phone.number);
                print(phoneController.text);
                if (Device.get().isAndroid) {
                  pValue.phoneNumber(
                    phone.completeNumber,
                    phone.countryCode.substring(1),
                    'ANDROID',
                  );
                } else {
                  pValue.phoneNumber(
                    phone.completeNumber,
                    phone.countryCode.substring(1),
                    'IOS',
                  );
                }
              }),
        ),
        const Spacer(),
      ],
    );
  }

  Row phoneNumberTextAndImageSection() {
    return Row(
      children: [
        SizedBox(
          height: 50,
          width: 40,
          child: Image.asset(
            elems,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        const Text(
          "Enter your Phone number",
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        const Spacer()
      ],
    );
  }
}
// import 'dart:convert';
// import 'dart:ffi';

// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flip_card/flip_card.dart';
// import 'package:flutter/material.dart';
// import 'package:fss_medical_app/providers/auth_provider.dart';
// import 'package:fss_medical_app/providers/phone_provider.dart';
// import 'package:fss_medical_app/screens/labRole/lab_basicdetails.dart';
// import 'package:fss_medical_app/screens/labRole/lab_dashboard.dart';
// import 'package:fss_medical_app/service/api_services.dart';
// import 'package:fss_medical_app/screens/authScreen/otp_section.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:provider/provider.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:flutter_device_type/flutter_device_type.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({Key? key}) : super(key: key);

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// String? aToken;
// String? uId;

// class _AuthScreenState extends State<AuthScreen> {
//   // bool isPresented = false;
//   static const int maxSeconds = 30;
//   int seconds = maxSeconds;
//   Bool? loginStatus;
//   Bool? userData;
//   final OtpFieldController _pinController = OtpFieldController();
//   final CountDownController _countDownController = CountDownController();
//   GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

//   bool isOver = false;
//   bool isOverr = false;
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
//     if (uName!.isNotEmpty) {
//       prefs.setString('userName', uName!);
//     }
//     if (email!.isNotEmpty) {
//       prefs.setString('email', email!);
//     }
//     if (profilePic!.isNotEmpty) {
//       prefs.setString('profilePicture', profilePic!);
//     }
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

//   bool isLoading = false;
//   String _phone = '';
//   //bool isOver = false;
//   final phoneController = TextEditingController();

//   String? appSignature;
//   String? otpCode;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<PhoneProvider, AuthProvider>(
//       builder: (context, p_value, a_value, child) {
//         String user_id = a_value.u_id;
//         String access_token = a_value.access_token;
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           appBar: AppBar(
//             elevation: 0,
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           ),
//           body: Column(
//             children: [
//               SizedBox(
//                 height: 30,
//               ),
//               const Text(
//                 'Enter your Phone Number',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20),
//               ),
//               SizedBox(
//                 height: 100,
//               ),
//               FlipCard(
//                 fill: Fill.fillBack,
//                 direction: FlipDirection.HORIZONTAL,
//                 key: cardKey,
//                 flipOnTouch: false,
//                 front: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Container(
//                     height: 300,
//                     decoration: BoxDecoration(
//                         color: Colors.blue[700],
//                         borderRadius: BorderRadius.all(Radius.circular(20))),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 70,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: IntlPhoneField(
//                                 controller: phoneController,
//                                 style: TextStyle(color: Colors.white),
//                                 dropdownTextStyle:
//                                     TextStyle(color: Colors.white),
//                                 dropdownIcon: Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.white,
//                                 ),
//                                 decoration: InputDecoration(
//                                   hintText: 'Phone Number',
//                                   hintStyle: TextStyle(color: Colors.white),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25.0),
//                                     borderSide: BorderSide(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   suffixIcon: Container(
//                                     margin: EdgeInsets.only(right: 10),
//                                     width: 10,
//                                     height: 10,
//                                     decoration: BoxDecoration(
//                                       color: p_value.phone.length > 12 &&
//                                               p_value.phone.length < 14
//                                           ? Colors.green
//                                           : Colors.red,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: context
//                                                     .watch<PhoneProvider>()
//                                                     .phone
//                                                     .length >
//                                                 12 &&
//                                             context
//                                                     .watch<PhoneProvider>()
//                                                     .phone
//                                                     .length <
//                                                 14
//                                         ? Icon(Icons.check, color: Colors.white)
//                                         : Icon(
//                                             Icons.close,
//                                             color: Colors.white,
//                                           ),
//                                   ),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(color: Colors.white),
//                                     borderRadius: BorderRadius.circular(50),
//                                   ),
//                                 ),
//                                 initialCountryCode: 'IN',
//                                 onChanged: (phone) async {
//                                   if (phone.number.length == 10) {
//                                     FocusManager.instance.primaryFocus!
//                                         .unfocus();
//                                   }
//                                   print(phone.completeNumber);
//                                   _phone = phone.number;
//                                   print(phone.countryCode.substring(1));
//                                   SharedPreferences prefs =
//                                       await SharedPreferences.getInstance();
//                                   prefs.setString("phoneNum", _phone);
//                                   print(phone.number);
//                                   print(phoneController.text);
//                                   if (Device.get().isAndroid) {
//                                     p_value.phoneNumber(
//                                       phone.completeNumber,
//                                       phone.countryCode.substring(1),
//                                       'ANDROID',
//                                     );
//                                   } else {
//                                     p_value.phoneNumber(
//                                       phone.completeNumber,
//                                       phone.countryCode.substring(1),
//                                       'IOS',
//                                     );
//                                   }
//                                 }),
//                           ),
//                           //  if (p_value.presented == true)
//                           SizedBox(height: 30),
//                           // if (p_value.presented == true) OtpSection(),
//                           ElevatedButton(
//                               onPressed: (() async {
//                                 if (p_value.phone.length > 12 &&
//                                     p_value.phone.length < 14) {
//                                   appSignature =
//                                       await SmsAutoFill().getAppSignature;
//                                   setState(() async {
//                                     p_value.isValid(true);
//                                     isLoading = true;
//                                     isOver = false;
//                                     ApiService()
//                                         .registerUser(
//                                             p_value.countryCode,
//                                             _phone,
//                                             p_value.type,
//                                             '7',
//                                             appSignature.toString())
//                                         .then((value) async {
//                                       print("_________________");
//                                       print(value.body);
//                                       // if (p_value.presented == true) {

//                                       // }

//                                       var jsonVal = jsonDecode(value.body);
//                                       // String otp = jsonVal['data']['otp'];
//                                       // print("___________________");
//                                       // print(otp);
//                                       // print("___________________");

//                                       print("json val===$jsonVal");
//                                       if (jsonVal['status'] == false) {
//                                         showDialog(
//                                           context: context,
//                                           builder: (ctx) => AlertDialog(
//                                             title: const Text("Message"),
//                                             content: Text(jsonVal['message']),
//                                             actions: <Widget>[
//                                               TextButton(
//                                                 onPressed: () {
//                                                   Navigator.of(ctx).pop();
//                                                 },
//                                                 child: Container(
//                                                   color: Colors.blue,
//                                                   padding: EdgeInsets.all(15),
//                                                   child: Text(
//                                                     "okay",
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       } else {
//                                         cardKey.currentState!.toggleCard();
//                                       }
//                                       String otp = jsonVal['data']['otp'];
//                                       print("___________________");
//                                       print(otp);
//                                       print("___________________");
//                                       var a_provider =
//                                           Provider.of<AuthProvider>(context,
//                                               listen: false);
//                                       a_provider.getDetails(
//                                           jsonVal['data']['user_id'].toString(),
//                                           jsonVal['data']['otp'].toString(),
//                                           jsonVal['data']['access_token']
//                                               .toString());
//                                       aToken = jsonVal['data']['access_token']
//                                           .toString();
//                                       uId =
//                                           jsonVal['data']['user_id'].toString();
//                                       print("token and id");
//                                       print(aToken);
//                                       print(uId);
//                                       //List<String> a = a_value.otp.split("");
//                                       List<String> a = otp.split("");
//                                       _pinController.setValue(a[0], 0);
//                                       _pinController.setValue(a[1], 1);
//                                       _pinController.setValue(a[2], 2);
//                                       _pinController.setValue(a[3], 3);
//                                       _pinController.setValue(a[4], 4);
//                                       _pinController.setValue(a[5], 5);
//                                       print("______________________");
//                                       print(a);
//                                       print("______________________");
//                                     });
//                                   });
//                                   _listenOtp();
//                                 }
//                               }),
//                               style: ElevatedButton.styleFrom(
//                                   elevation: 3,
//                                   //fixedSize: Size(90, 40),
//                                   backgroundColor: Colors.white),
//                               // onPressed: () => cardKey.currentState!.toggleCard(),
//                               child: const Text(
//                                 "Verify",
//                                 style: TextStyle(color: Colors.black),
//                               ))
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 back: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Container(
//                     height: 300,
//                     decoration: BoxDecoration(
//                         color: Colors.blue[700],
//                         borderRadius: BorderRadius.all(Radius.circular(20))),
//                     child:
//                         // Center(child: OtpSection()),
//                         Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 25,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'OTP sent to ${p_value.phone}',
//                                 style: const TextStyle(
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     p_value.isValid(false);
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.edit,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Spacer(),
//                               if (isOverr)
//                                 InkWell(
//                                   onTap: () {
//                                     ApiService().resendOTP(a_value.u_id);
//                                     setState(() {
//                                       isOverr = false;
//                                     });
//                                   },
//                                   child: const Flexible(
//                                       child: Text(
//                                     'Resend OTP',
//                                     style: TextStyle(fontSize: 10),
//                                   )),
//                                 )
//                               else
//                                 CircularCountDownTimer(
//                                     width:
//                                         MediaQuery.of(context).size.width / 8,
//                                     height:
//                                         MediaQuery.of(context).size.height / 8,
//                                     duration: 20,
//                                     fillColor: Colors.purple,
//                                     ringColor: Colors.amber,
//                                     controller: _countDownController,
//                                     textStyle: const TextStyle(
//                                       fontSize: 18.0,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     textFormat: CountdownTextFormat.S,
//                                     isReverse: true,
//                                     isReverseAnimation: true,
//                                     onComplete: () =>
//                                         setState(() => isOverr = true)),

//                               // buildTimer(),
//                             ],
//                           ),
//                           const SizedBox(height: 30),
//                           OTPTextField(
//                               length: 6,
//                               width: MediaQuery.of(context).size.width,
//                               fieldWidth: 50,
//                               controller: _pinController,
//                               //controller: _pinController,
//                               textFieldAlignment: MainAxisAlignment.spaceAround,
//                               fieldStyle: FieldStyle.box,
//                               style: const TextStyle(fontSize: 17),
//                               onChanged: (val) {
//                                 Future.delayed(const Duration(seconds: 1), (() {
//                                   print(val);
//                                   print('changed');
//                                   print(a_value.otp);
//                                   print(_pinController);
//                                   if (val == a_value.otp) {
//                                     // _countDownController.pause();
//                                     ApiService()
//                                         .verifyOTP(a_value.u_id,
//                                             a_value.access_token, val)
//                                         .then((value) async {
//                                       // print(value.body);

//                                       if (value.statusCode == 200) {
//                                         var jsonData =
//                                             jsonDecode(value.body)['data'];
//                                         SharedPreferences prefs =
//                                             await SharedPreferences
//                                                 .getInstance();
//                                         prefs.setString(
//                                             'user_id', jsonData['user_id']);
//                                         prefs.setString('access_token',
//                                             jsonData['access_token']);

//                                         user_id = jsonData['user_id'];
//                                         access_token = jsonData['access_token'];
//                                         role = jsonData['user_type'];
//                                        // setUserId();
//                                         print("user id");
//                                         print(a_value.u_id);
//                                         print(access_token);
//                                         print("userId and token===");
//                                         print(user_id);
//                                         print(access_token);

//                                         print(jsonData['login_status']);
//                                         //print(role);
//                                       if(jsonData['login_status'].toString()=='0') {
//                                         Navigator.pushReplacement(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (_) =>
//                                                         const LabBasicDetails()));
//                                       }
//                                       else{
//                                          Navigator.pushReplacement(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (_) =>
//                                                         const LabDashboard()));
//                                       }
                                      
//                                         _countDownController.pause();
//                                       }
//                                       // print("USER: ==> ${}")
//                                     });
//                                   } else {
//                                     // print("wrogggggggggggggggggggge");
//                                     // ScaffoldMessenger.of(context)
//                                     //     .showSnackBar(SnackBar(
//                                     //   content: Text(
//                                     //     "Invalid Otp",
//                                     //     style: TextStyle(color: Colors.white),
//                                     //   ),
//                                     //   backgroundColor: Colors.blue[800],
//                                     //   elevation: 10,
//                                     // ));
//                                   }

//                                   // print(_pinController.text);
//                                   // print(a_value.u_id);
//                                   // print(a_value.access_token);
//                                 }));
//                               },
//                               onCompleted: (val) {}

//                               //controller: _pinController,
//                               )
                         
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
         
//         );
//       },
//     );
//   }

//   void _listenOtp() async {
//     await SmsAutoFill().listenForCode;
//   }
// }
