
import 'dart:convert';

class GetLabTestList {
    final bool status;
    final int statuscode;
    final String message;
    final List<Datum> data;

    GetLabTestList({
        required this.status,
        required this.statuscode,
        required this.message,
        required this.data,
    });

    factory GetLabTestList.fromRawJson(String str) => GetLabTestList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetLabTestList.fromJson(Map<String, dynamic> json) => GetLabTestList(
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
    final String createdDatetime;
    final String userId;
    final String test;
    final String consultingFee;
    final String consultingFeeHistory;
    final String testMethodId;
    final String status;
    final String method;

    Datum({
        required this.id,
        required this.createdDatetime,
        required this.userId,
        required this.test,
        required this.consultingFee,
        required this.consultingFeeHistory,
        required this.testMethodId,
        required this.status,
        required this.method,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdDatetime: json["created_datetime"],
        userId: json["user_id"],
        test: json["test"],
        consultingFee: json["consulting_fee"],
        consultingFeeHistory: json["consulting_fee_history"],
        testMethodId: json["test_method_id"],
        status: json["status"],
        method: json["method"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_datetime": createdDatetime,
        "user_id": userId,
        "test": test,
        "consulting_fee": consultingFee,
        "consulting_fee_history": consultingFeeHistory,
        "test_method_id": testMethodId,
        "status": status,
        "method": method,
    };
}
