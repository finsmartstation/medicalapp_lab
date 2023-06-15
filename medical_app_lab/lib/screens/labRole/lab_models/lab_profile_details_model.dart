// To parse this JSON data, do
//
//     final getLabProfileDetails = getLabProfileDetailsFromJson(jsonString);

import 'dart:convert';

class GetLabProfileDetails {
    final bool status;
    final int statuscode;
    final String message;
    final Data data;

    GetLabProfileDetails({
        required this.status,
        required this.statuscode,
        required this.message,
        required this.data,
    });

    factory GetLabProfileDetails.fromRawJson(String str) => GetLabProfileDetails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetLabProfileDetails.fromJson(Map<String, dynamic> json) => GetLabProfileDetails(
        status: json["status"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statuscode": statuscode,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final BasicDetails basicDetails;
    final int experience;
    final String specialization;

    Data({
        required this.basicDetails,
        required this.experience,
        required this.specialization,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        basicDetails: BasicDetails.fromJson(json["basic_details"]),
        experience: json["experience"],
        specialization: json["specialization"],
    );

    Map<String, dynamic> toJson() => {
        "basic_details": basicDetails.toJson(),
        "experience": experience,
        "specialization": specialization,
    };
}

class BasicDetails {
    final String id;
    final String userId;
    final String accessToken;
    final String firebaseToken;
    final String appSignatureId;
    final String username;
    final DateTime createdDatetime;
    final String accessId;
    final String email;
    final String countryId;
    final String countryCode;
    final String currencyId;
    final String mobile;
    final String otp;
    final String otpStatus;
    final String latitude;
    final String longitude;
    final String deviceType;
    final String loginStatus;
    final String familyDoctorId;
    final String status;
    final String profilePic;
    final String gst;
    final String address;
    final String state;
    final String ownership;
    final String establishedDate;
    final String pincode;
    final String logo;
    final String emergencyContact;
    final String proHalfPath;
    final String logoHalfPath;

    BasicDetails({
        required this.id,
        required this.userId,
        required this.accessToken,
        required this.firebaseToken,
        required this.appSignatureId,
        required this.username,
        required this.createdDatetime,
        required this.accessId,
        required this.email,
        required this.countryId,
        required this.countryCode,
        required this.currencyId,
        required this.mobile,
        required this.otp,
        required this.otpStatus,
        required this.latitude,
        required this.longitude,
        required this.deviceType,
        required this.loginStatus,
        required this.familyDoctorId,
        required this.status,
        required this.profilePic,
        required this.gst,
        required this.address,
        required this.state,
        required this.ownership,
        required this.establishedDate,
        required this.pincode,
        required this.logo,
        required this.emergencyContact,
        required this.proHalfPath,
        required this.logoHalfPath,
    });

    factory BasicDetails.fromRawJson(String str) => BasicDetails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BasicDetails.fromJson(Map<String, dynamic> json) => BasicDetails(
        id: json["id"],
        userId: json["user_id"],
        accessToken: json["access_token"],
        firebaseToken: json["firebase_token"],
        appSignatureId: json["app_signature_id"],
        username: json["username"],
        createdDatetime: DateTime.parse(json["created_datetime"]),
        accessId: json["access_id"],
        email: json["email"],
        countryId: json["country_id"],
        countryCode: json["country_code"],
        currencyId: json["currency_id"],
        mobile: json["mobile"],
        otp: json["otp"],
        otpStatus: json["otp_status"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        deviceType: json["device_type"],
        loginStatus: json["login_status"],
        familyDoctorId: json["family_doctor_id"],
        status: json["status"],
        profilePic: json["profile_pic"],
        gst: json["gst"],
        address: json["address"],
        state: json["state"],
        ownership: json["ownership"],
        establishedDate: json["established_date"],
        pincode: json["pincode"],
        logo: json["logo"],
        emergencyContact: json["emergency_contact"],
        proHalfPath: json["pro_half_path"],
        logoHalfPath: json["logo_half_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "access_token": accessToken,
        "firebase_token": firebaseToken,
        "app_signature_id": appSignatureId,
        "username": username,
        "created_datetime": createdDatetime.toIso8601String(),
        "access_id": accessId,
        "email": email,
        "country_id": countryId,
        "country_code": countryCode,
        "currency_id": currencyId,
        "mobile": mobile,
        "otp": otp,
        "otp_status": otpStatus,
        "latitude": latitude,
        "longitude": longitude,
        "device_type": deviceType,
        "login_status": loginStatus,
        "family_doctor_id": familyDoctorId,
        "status": status,
        "profile_pic": profilePic,
        "gst": gst,
        "address": address,
        "state": state,
        "ownership": ownership,
        "established_date": establishedDate,
        "pincode": pincode,
        "logo": logo,
        "emergency_contact": emergencyContact,
        "pro_half_path": proHalfPath,
        "logo_half_path": logoHalfPath,
    };
}
