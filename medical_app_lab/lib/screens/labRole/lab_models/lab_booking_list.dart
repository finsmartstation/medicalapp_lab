// To parse this JSON data, do
//
//     final getLabBookingList = getLabBookingListFromJson(jsonString);

import 'dart:convert';

class GetLabBookingList {
    final bool status;
    final int statuscode;
    final String message;
    final List<Datum> data;

    GetLabBookingList({
        required this.status,
        required this.statuscode,
        required this.message,
        required this.data,
    });

    factory GetLabBookingList.fromRawJson(String str) => GetLabBookingList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetLabBookingList.fromJson(Map<String, dynamic> json) => GetLabBookingList(
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
    final Master master;
    final List<Sub> sub;

    Datum({
        required this.master,
        required this.sub,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        master: Master.fromJson(json["master"]),
        sub: List<Sub>.from(json["sub"].map((x) => Sub.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "master": master.toJson(),
        "sub": List<dynamic>.from(sub.map((x) => x.toJson())),
    };
}

class Master {
    final String id;
    final DateTime createdDatetime;
    final String userId;
    final String labUserId;
    final String familyMemberId;
    final String labTestId;
    final String doctorId;
    final String labTechnicianId;
    final String addedBy;
    final String currencyId;
    final String previousBookSlot;
    final String visitType;
    final String doctorPrescription;
    final String userNotes;
    final String numberOfTest;
    final String amount;
    final String gstPercentage;
    final String totalAmount;
    final String paymentMethod;
    final String transactionId;
    final String paymentStatus;
    final String reportPath;
    final String reportDatetime;
    final String invoicePath;
    final String stickersPath;
    final String stickerCode;
    final String status;
    final String username;
    final String labName;
    final String familyMemberName;
    final String doctorName;
    final String labTechnicianName;

    Master({
        required this.id,
        required this.createdDatetime,
        required this.userId,
        required this.labUserId,
        required this.familyMemberId,
        required this.labTestId,
        required this.doctorId,
        required this.labTechnicianId,
        required this.addedBy,
        required this.currencyId,
        required this.previousBookSlot,
        required this.visitType,
        required this.doctorPrescription,
        required this.userNotes,
        required this.numberOfTest,
        required this.amount,
        required this.gstPercentage,
        required this.totalAmount,
        required this.paymentMethod,
        required this.transactionId,
        required this.paymentStatus,
        required this.reportPath,
        required this.reportDatetime,
        required this.invoicePath,
        required this.stickersPath,
        required this.stickerCode,
        required this.status,
        required this.username,
        required this.labName,
        required this.familyMemberName,
        required this.doctorName,
        required this.labTechnicianName,
    });

    factory Master.fromRawJson(String str) => Master.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Master.fromJson(Map<String, dynamic> json) => Master(
        id: json["id"],
        createdDatetime: DateTime.parse(json["created_datetime"]),
        userId: json["user_id"],
        labUserId: json["lab_user_id"],
        familyMemberId: json["family_member_id"],
        labTestId: json["lab_test_id"],
        doctorId: json["doctor_id"],
        labTechnicianId: json["lab_technician_id"],
        addedBy: json["added_by"],
        currencyId: json["currency_id"],
        previousBookSlot: json["previous_book_slot"],
        visitType: json["visit_type"],
        doctorPrescription: json["doctor_prescription"],
        userNotes: json["user_notes"],
        numberOfTest: json["number_of_test"],
        amount: json["amount"],
        gstPercentage: json["gst_percentage"],
        totalAmount: json["total_amount"],
        paymentMethod: json["payment_method"],
        transactionId: json["transaction_id"],
        paymentStatus: json["payment_status"],
        reportPath: json["report_path"],
        reportDatetime: json["report_datetime"],
        invoicePath: json["invoice_path"],
        stickersPath: json["stickers_path"],
        stickerCode: json["sticker_code"],
        status: json["status"],
        username: json["username"],
        labName: json["lab_name"],
        familyMemberName: json["family_member_name"],
        doctorName: json["doctor_name"],
        labTechnicianName: json["lab_technician_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_datetime": createdDatetime.toIso8601String(),
        "user_id": userId,
        "lab_user_id": labUserId,
        "family_member_id": familyMemberId,
        "lab_test_id": labTestId,
        "doctor_id": doctorId,
        "lab_technician_id": labTechnicianId,
        "added_by": addedBy,
        "currency_id": currencyId,
        "previous_book_slot": previousBookSlot,
        "visit_type": visitType,
        "doctor_prescription": doctorPrescription,
        "user_notes": userNotes,
        "number_of_test": numberOfTest,
        "amount": amount,
        "gst_percentage": gstPercentage,
        "total_amount": totalAmount,
        "payment_method": paymentMethod,
        "transaction_id": transactionId,
        "payment_status": paymentStatus,
        "report_path": reportPath,
        "report_datetime": reportDatetime,
        "invoice_path": invoicePath,
        "stickers_path": stickersPath,
        "sticker_code": stickerCode,
        "status": status,
        "username": username,
        "lab_name": labName,
        "family_member_name": familyMemberName,
        "doctor_name": doctorName,
        "lab_technician_name": labTechnicianName,
    };
}

class Sub {
    final String id;
    final String bookLabTestId;
    final String labTestId;
    final String amount;
    final String testResult;
    final String testNotes;
    final String status;
    final String test;
    final String consultingFee;
    final String unit;

    Sub({
        required this.id,
        required this.bookLabTestId,
        required this.labTestId,
        required this.amount,
        required this.testResult,
        required this.testNotes,
        required this.status,
        required this.test,
        required this.consultingFee,
        required this.unit,
    });

    factory Sub.fromRawJson(String str) => Sub.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sub.fromJson(Map<String, dynamic> json) => Sub(
        id: json["id"],
        bookLabTestId: json["book_lab_test_id"],
        labTestId: json["lab_test_id"],
        amount: json["amount"],
        testResult: json["test_result"],
        testNotes: json["test_notes"],
        status: json["status"],
        test: json["test"],
        consultingFee: json["consulting_fee"],
        unit: json["unit"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "book_lab_test_id": bookLabTestId,
        "lab_test_id": labTestId,
        "amount": amount,
        "test_result": testResult,
        "test_notes": testNotes,
        "status": status,
        "test": test,
        "consulting_fee": consultingFee,
        "unit": unit,
    };
}
