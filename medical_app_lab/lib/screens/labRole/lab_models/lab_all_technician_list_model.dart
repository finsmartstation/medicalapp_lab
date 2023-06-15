// To parse this JSON data, do
//
//     final getAllLabTechnicianList = getAllLabTechnicianListFromJson(jsonString);

import 'dart:convert';

class GetAllLabTechnicianList {
    final bool status;
    final int statuscode;
    final String message;
    final List<Datum> data;

    GetAllLabTechnicianList({
        required this.status,
        required this.statuscode,
        required this.message,
        required this.data,
    });

    factory GetAllLabTechnicianList.fromRawJson(String str) => GetAllLabTechnicianList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetAllLabTechnicianList.fromJson(Map<String, dynamic> json) => GetAllLabTechnicianList(
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
    final String employeeId;
    final String employeeName;
    final String employeePhone;
    final String profilePic;

    Datum({
        required this.employeeId,
        required this.employeeName,
        required this.employeePhone,
        required this.profilePic,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        employeeId: json["employee_id"],
        employeeName: json["employee_name"],
        employeePhone: json["employee_phone"],
        profilePic: json["profile_pic"],
    );

    Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "employee_name": employeeName,
        "employee_phone": employeePhone,
        "profile_pic": profilePic,
    };
}
