import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_app_lab/screens/labRole/lab_models/lab_all_doctors_list.dart';
import 'package:medical_app_lab/screens/labRole/lab_models/lab_all_patient_list.dart';
import 'package:medical_app_lab/screens/labRole/lab_models/lab_booking_list.dart';
import 'package:medical_app_lab/screens/labRole/lab_models/lab_family_member_list.dart';
import 'package:medical_app_lab/screens/labRole/lab_models/lab_test_list_model.dart';
import '../../utility/constants.dart';
import 'lab_models/lab_all_technician_list_model.dart';
import 'lab_models/lab_profile_details_model.dart';
import 'lab_models/lab_technician_list_model.dart';
class LabApiServices{
    Future<http.Response> fillLabBasicDetails(userId, accessToken,
      name, email, image) async {
    String url = baseUrl + 'fill_lab_basic_details';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'username': name,
      'email': email,
      'profile_pic': image,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: obj);
    print(respons.body);
    return respons;
  }
  Future<http.Response> addLabTechnician(userId, accessToken,
      username, mobile, employeeId) async {
    String url = baseUrl + 'add_lab_technician';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'employee_id': employeeId,
      'mobile': mobile,
      'username': username,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
  Future<GetLabTechnicianList> listLabTechnician(userId, accessToken) async {
    String url = baseUrl + 'list_lab_technician';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: obj);
    print(respons.body);
    if (respons.statusCode == 200) {
      final data = GetLabTechnicianList.fromJson(jsonDecode(respons.body));
      print(data);
      return data;
    } else {
      throw Exception('Failed to load users');
    }
  }
   Future<http.Response> addLabTest(userId, accessToken,
      test, consultingFee, methodId) async {
    String url = baseUrl + 'save_lab_test_details';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'test': test,
      'consulting_fee': consultingFee,
      'test_method_id': methodId,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
  Future<GetLabTestList> listLabTest(userId, accessToken) async {
    String url = baseUrl + 'list_lab_test_details';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: obj);
    print("response body");
    print(respons.body);
    if (respons.statusCode == 200) {
      final data = GetLabTestList.fromJson(jsonDecode(respons.body));
      print("data");
      print(data);
      return data;
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<http.Response> updateLabTest(userId, accessToken,
      test, consultingFee, methodId,id) async {
    String url = baseUrl + 'update_lab_test_details';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'test': test,
      'consulting_fee': consultingFee,
      'test_method_id': methodId,
      'id':id
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
  Future<GetAllLabTechnicianList> listAllLabTechnician(userId, accessToken) async {
    String url = baseUrl + 'all_lab_technician_user';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: obj);
    print(respons.body);
    if (respons.statusCode == 200) {
      final data = GetAllLabTechnicianList.fromJson(jsonDecode(respons.body));
      print(data);
      return data;
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<http.Response> deleteLabTest(userId, accessToken,
      id) async {
    String url = baseUrl + 'delete_lab_test_details';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'id':id
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
  Future<http.Response> deleteLabTechnician(userId, accessToken,
      id) async {
    String url = baseUrl + 'delete_lab_technician';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'id':id
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
   Future<http.Response> fillLabProfile(userId, accessToken,
      name, email, lat, long, profile, address, state, ownership, gst, establishedDate, pincode,
      logo, contact) async {
    String url = baseUrl + 'fill_lab_profile';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'username': name,
      'email': email,
      'latitude':lat,
      'longitude':long,
      'profile_pic': profile,
      'address': address,
      'state': state,
      'ownership': ownership,
      'gst':gst,
      'established_date':establishedDate,
      'pincode':pincode,
      'logo':logo,
      'emergency_contact':contact
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
  Future<GetLabProfileDetails> getLabProfileDetails(userId, accessToken) async {
    String url = baseUrl + 'get_lab_profile';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: obj);
    print(respons.body);
    if (respons.statusCode == 200) {
      final data = GetLabProfileDetails.fromJson(jsonDecode(respons.body));
      print(data);
      return data;
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<http.Response> updateLabProfile(userId, accessToken,
      profile) async {
    String url = baseUrl + 'update_profilepic';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'profile_pic':profile
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
  Future<http.Response> updateLabLogo(userId, accessToken,
      logo) async {
    String url = baseUrl + 'update_logo';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'logo':logo
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
  Future<http.Response> bookLabTest(userId, accessToken,patientId,
      doctorId,  labtestId, familymemberId, labtechnicianId, paymentMethod, transactionId,paymentStatus,
      visitType,doctorPrescription , userNotes ) async {
    String url = baseUrl + 'add_book_user_lab_test_by_lab';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'doctor_id':doctorId,
      'patient_id':patientId,
      'lab_test_id':labtestId,
      'family_member_id':familymemberId,
      'lab_technician_id':labtechnicianId,
      'payment_method':paymentMethod,
      'transaction_id':transactionId,
      'payment_status':paymentStatus,
      'visit_type':visitType,
      'doctor_prescription':doctorPrescription,
      'user_notes':userNotes
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
  Future<GetDoctorList> getDoctorsList(userId, accessToken) async {
    String url = baseUrl + 'list_all_doctors';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: obj);
    print(respons.body);
    if (respons.statusCode == 200) {
      final data = GetDoctorList.fromJson(jsonDecode(respons.body));
      print(data);
      return data;
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<GetLabBookingList> getLabBookingList(userId, accessToken) async {
    String url = baseUrl + 'book_user_lab_test_by_lab_list';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: obj);
    print(respons.body);
    if (respons.statusCode == 200) {
      final data = GetLabBookingList.fromJson(jsonDecode(respons.body));
      print(data);
      return data;
    } else {
      throw Exception('Failed to load users');
    }
  }
    Future<http.Response> updateLabTestReport(userId, accessToken,
      id, subId, testResult, testNote ) async {
    String url = baseUrl + 'update_book_user_lab_test_report';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      // 'user_id': '11',
      // 'access_token': '4f622a5884ee0632184302966d52564e',
      'id':id,
      'sub_id':subId,
      'test_result':testResult,
      'test_notes':testNote,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
  Future<GetAllPatientList> getPatientList(userId, accessToken) async {
    String url = baseUrl + 'list_all_patient';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: obj);
    print(respons.body);
    if (respons.statusCode == 200) {
      final data = GetAllPatientList.fromJson(jsonDecode(respons.body));
      print(data);
      return data;
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<GetFamilyMemberList> getFamilyMemberList(userId, accessToken) async {
    String url = baseUrl + 'list_family_members';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: obj);
    print(respons.body);
    if (respons.statusCode == 200) {
      final data = GetFamilyMemberList.fromJson(jsonDecode(respons.body));
      print(data);
      return data;
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<http.Response> deleteLabBooking(userId, accessToken,
      id) async {
    String url = baseUrl + 'delete_book_user_lab_test_by_lab_master';
    var obj = {
      'user_id': userId,
      'access_token': accessToken,
      'id':id
    };
    print(obj);
    var respons = await http.post(Uri.parse(url), body: jsonEncode(obj));
    print(respons.body);
    return respons;
  }
}