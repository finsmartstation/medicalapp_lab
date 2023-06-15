// To parse this JSON data, do
//
//     final getDoctorList = getDoctorListFromJson(jsonString);

import 'dart:convert';

class GetDoctorList {
    final bool status;
    final int statuscode;
    final String message;
    final List<Datum> data;

    GetDoctorList({
        required this.status,
        required this.statuscode,
        required this.message,
        required this.data,
    });

    factory GetDoctorList.fromRawJson(String str) => GetDoctorList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetDoctorList.fromJson(Map<String, dynamic> json) => GetDoctorList(
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
    final String doctorId;
    final String doctorName;
    final String profilePic;
    final dynamic experience;
    final int favouriteDoctorStatus;
    final int familyDoctorStatus;
    final String organisation;
    final String specialization;

    Datum({
        required this.doctorId,
        required this.doctorName,
        required this.profilePic,
        required this.experience,
        required this.favouriteDoctorStatus,
        required this.familyDoctorStatus,
        required this.organisation,
        required this.specialization,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        doctorId: json["doctor_id"],
        doctorName: json["doctor_name"],
        profilePic: json["profile_pic"],
        experience: json["experience"],
        favouriteDoctorStatus: json["favourite_doctor_status"],
        familyDoctorStatus: json["family_doctor_status"],
        organisation: json["organisation"],
        specialization: json["specialization"],
    );

    Map<String, dynamic> toJson() => {
        "doctor_id": doctorId,
        "doctor_name": doctorName,
        "profile_pic": profilePic,
        "experience": experience,
        "favourite_doctor_status": favouriteDoctorStatus,
        "family_doctor_status": familyDoctorStatus,
        "organisation": organisation,
        "specialization": specialization,
    };
}
