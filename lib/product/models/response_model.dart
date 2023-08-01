import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  bool? success;
  String? message;
  dynamic data;

  ResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ResponseModelToJson(this);
  }

  /* factory BaseModel.defaultError(Map<String, dynamic> json) => BaseModel(
        success: json['success'],
        message: json['message'],
        data: null,
      ); */
}
