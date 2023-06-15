// To parse this JSON data, do
//
//     final getFamilyMemberList = getFamilyMemberListFromJson(jsonString);

import 'dart:convert';

class GetFamilyMemberList {
    final bool status;
    final int statuscode;
    final String message;
    final List<Datum> data;

    GetFamilyMemberList({
        required this.status,
        required this.statuscode,
        required this.message,
        required this.data,
    });

    factory GetFamilyMemberList.fromRawJson(String str) => GetFamilyMemberList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetFamilyMemberList.fromJson(Map<String, dynamic> json) => GetFamilyMemberList(
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
    final DateTime addedDatetime;
    final String familyMemberId;
    final String emailId;
    final String username;
    final String profilePic;
    final DateTime updatedDatetime;
    final String relation;
    final String dob;
    final String gender;
    final String bloodGroup;
    final String height;
    final String weight;
    final String generateQrcode;
    final String defaultStatus;
    final String status;

    Datum({
        required this.id,
        required this.userId,
        required this.addedDatetime,
        required this.familyMemberId,
        required this.emailId,
        required this.username,
        required this.profilePic,
        required this.updatedDatetime,
        required this.relation,
        required this.dob,
        required this.gender,
        required this.bloodGroup,
        required this.height,
        required this.weight,
        required this.generateQrcode,
        required this.defaultStatus,
        required this.status,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        addedDatetime: DateTime.parse(json["added_datetime"]),
        familyMemberId: json["family_member_id"],
        emailId: json["email_id"],
        username: json["username"],
        profilePic: json["profile_pic"],
        updatedDatetime: DateTime.parse(json["updated_datetime"]),
        relation: json["relation"],
        dob: json["dob"],
        gender: json["gender"],
        bloodGroup: json["blood_group"],
        height: json["height"],
        weight: json["weight"],
        generateQrcode: json["generate_qrcode"],
        defaultStatus: json["default_status"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "added_datetime": addedDatetime.toIso8601String(),
        "family_member_id": familyMemberId,
        "email_id": emailId,
        "username": username,
        "profile_pic": profilePic,
        "updated_datetime": updatedDatetime.toIso8601String(),
        "relation": relation,
        "dob": dob,
        "gender": gender,
        "blood_group": bloodGroup,
        "height": height,
        "weight": weight,
        "generate_qrcode": generateQrcode,
        "default_status": defaultStatus,
        "status": status,
    };
}
