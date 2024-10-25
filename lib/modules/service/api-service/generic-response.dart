import 'package:json_annotation/json_annotation.dart';
part 'generic-response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class GenericResponse<T> {
  String? message;
  List<T>? data;
  String? status;

  GenericResponse({this.message, this.data, this.status});

  // Constructor to directly create from a list for simple lists like List<String> or List<int>
  factory GenericResponse.fromList(
      List<dynamic> jsonList, T Function(dynamic) parseItem) {
    return GenericResponse<T>(
      data: jsonList.map((item) => parseItem(item)).toList(),
      status: "200", // You can set a default status if needed
    );
  }

  factory GenericResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final dynamic responseData = json['data'];

    List<T>? parsedData;

    if (responseData is List) {
      parsedData = responseData
          .map<T>((item) => fromJsonT(item as Map<String, dynamic>))
          .toList();
    } else if (responseData is Map<String, dynamic>) {
      parsedData = [fromJsonT(responseData)];
    }

    return GenericResponse<T>(
      message: json['message'] as String?,
      data: parsedData,
      status: json['status'] as String?,
    );
  }

  // toJson method for serialization
  Map<String, dynamic> toJson(Object Function(T) toJsonT) {
    return {
      'message': message,
      'data': data?.map((item) => toJsonT(item)).toList(),
      'status': status,
    };
  }
}
