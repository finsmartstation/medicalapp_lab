import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:medical_app_lab/providers/auth_provider.dart';
import 'package:medical_app_lab/utility/constants.dart';

class ApiService {
  String _u_id = '';
  String _otp = '';
  String _access_token = '';
  AuthProvider authProvider = AuthProvider();
    Future<http.Response> registerUser(String c_code, String phone, String type,
      String a_id, String sign) async {
    String url = baseUrl + 'register';
    var obj = {
      'country_code': c_code,
      'mobile': phone,
      'device_type': type,
      'access_id': a_id,
      'app_signature_id': sign,
    };
    print('OBJECT : ${obj}');
    var response = await http.post(Uri.parse(url), body: obj);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print('RESPONSE: ${jsonData}');
      if(jsonData['status']=="false"){
      authProvider.getDetails(
          jsonData['user_id'], jsonData['otp'], jsonData['access_token']);
      }
    }
    return response;
  }

  // Resend OTP

  Future<void> resendOTP(String id) async {
    String url = baseUrl + 'resend_otp';
    var obj = {
      'user_id': id,
    };

    var response = await http.post(Uri.parse(url), body: obj);

    if (response.statusCode == 200) {
      var jsonOTP = jsonDecode(response.body)['data'];
      print('OTP : ${jsonOTP}');
    }
  }

  // Verify OTP

  Future<http.Response> verifyOTP(
      String userId, String access_token, String otp) async {
    String url = baseUrl + 'verify_otp';
    var obj = {
      "user_id": userId,
      "access_token": access_token,
      "otp": otp,
    };
    var response = await http.post(Uri.parse(url), body: obj);
    return response;
  }
   //file_upload
  Future<http.StreamedResponse> file_upload(user_id, access_token, file) async {
    String url = baseUrl + 'file_upload';
     var obj = {
      'user_id': user_id,
      'access_token': access_token,
      "file":file
    };
    print("obj==$obj");
    var request = http.MultipartRequest("POST", Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', file));
    request.fields['user_id'] = user_id;
    request.fields['access_token'] = access_token;
    var resp = await request.send();
    return resp;
  }
}