// To parse this JSON data, do
//
//     final getLabTechnicianList = getLabTechnicianListFromJson(jsonString);

import 'dart:convert';

class GetLabTechnicianList {
    final bool status;
    final int statuscode;
    final String message;
    final List<Datum> data;

    GetLabTechnicianList({
        required this.status,
        required this.statuscode,
        required this.message,
        required this.data,
    });

    factory GetLabTechnicianList.fromRawJson(String str) => GetLabTechnicianList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetLabTechnicianList.fromJson(Map<String, dynamic> json) => GetLabTechnicianList(
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
    final String employeeId;
    final DateTime addedDatetime;
    final String username;
    final String mobile;
    final String employeeAcceptStatus;
    final String checkAvailable;
    final String status;

    Datum({
        required this.id,
        required this.userId,
        required this.employeeId,
        required this.addedDatetime,
        required this.username,
        required this.mobile,
        required this.employeeAcceptStatus,
        required this.checkAvailable,
        required this.status,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        employeeId: json["employee_id"],
        addedDatetime: DateTime.parse(json["added_datetime"]),
        username: json["username"],
        mobile: json["mobile"],
        employeeAcceptStatus: json["employee_accept_status"],
        checkAvailable: json["check_available"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "employee_id": employeeId,
        "added_datetime": addedDatetime.toIso8601String(),
        "username": username,
        "mobile": mobile,
        "employee_accept_status": employeeAcceptStatus,
        "check_available": checkAvailable,
        "status": status,
    };
}
