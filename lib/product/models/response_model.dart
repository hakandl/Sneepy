import 'package:easy_localization/easy_localization.dart';
import 'package:sneepy/product/init/language/locale_keys.g.dart';

class ResponseModel {
  bool? success;
  String? message;
  dynamic data;

  ResponseModel({
    this.success,
    this.message,
    this.data,
  });

  ResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? LocaleKeys.thereIsProblem.tr();
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['message'] = message;
    json['data'] = data;
    return json;
  }

  /* factory BaseModel.defaultError(Map<String, dynamic> json) => BaseModel(
        success: json['success'],
        message: json['message'],
        data: null,
      ); */
}
