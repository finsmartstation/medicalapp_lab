// To parse this JSON data, do
//
//     final getAllPatientList = getAllPatientListFromJson(jsonString);

import 'dart:convert';

class GetAllPatientList {
    final bool status;
    final int statuscode;
    final String message;
    final List<Datum> data;

    GetAllPatientList({
        required this.status,
        required this.statuscode,
        required this.message,
        required this.data,
    });

    factory GetAllPatientList.fromRawJson(String str) => GetAllPatientList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetAllPatientList.fromJson(Map<String, dynamic> json) => GetAllPatientList(
        status: json["status"],
        statuscode: json["statuscode"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statuscode": statuscode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
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
    final DeviceType deviceType;
    final String loginStatus;
    final String availableStatus;
    final String familyDoctorId;
    final String status;

    Datum({
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
        required this.availableStatus,
        required this.familyDoctorId,
        required this.status,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        accessToken: json["access_token"],
        firebaseToken: json["firebase_token"],
        appSignatureId: json["app_signature_id"].toString(),
        username: json["username"].toString(),
        createdDatetime: DateTime.parse(json["created_datetime"]),
        accessId: json["access_id"],
        email: json["email"].toString(),
        countryId: json["country_id"],
        countryCode: json["country_code"],
        currencyId: json["currency_id"],
        mobile: json["mobile"],
        otp: json["otp"],
        otpStatus: json["otp_status"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        deviceType: deviceTypeValues.map[json["device_type"]]!,
        loginStatus: json["login_status"],
        availableStatus: json["available_status"],
        familyDoctorId: json["family_doctor_id"],
        status: json["status"],
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
        "device_type": deviceTypeValues.reverse[deviceType],
        "login_status": loginStatus,
        "available_status": availableStatus,
        "family_doctor_id": familyDoctorId,
        "status": status,
    };
}

// enum AppSignatureId { ZYS_GP_BV2_ER, EMPTY, KC_DH_IXQD_X4_Z, THE_3_Z_BTCY_AX_SP_O, YOD_IQCZ6_AUV, D_UI3_II_NQHC_L }

// final appSignatureIdValues = EnumValues({
//     "dUi3IiNqhcL": AppSignatureId.D_UI3_II_NQHC_L,
//     "": AppSignatureId.EMPTY,
//     "kcDhIxqdX4Z": AppSignatureId.KC_DH_IXQD_X4_Z,
//     "3ZBtcyAxSpO": AppSignatureId.THE_3_Z_BTCY_AX_SP_O,
//     "YodIQCZ6auv": AppSignatureId.YOD_IQCZ6_AUV,
//     "ZYSGp/BV2ER": AppSignatureId.ZYS_GP_BV2_ER
// });

enum DeviceType { ANDROID, IOS }

final deviceTypeValues = EnumValues({
    "ANDROID": DeviceType.ANDROID,
    "IOS": DeviceType.IOS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
