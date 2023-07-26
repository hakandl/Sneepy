class ResponseModel {
  bool? success;
  // String? token;
  String? message;
  dynamic data;

  ResponseModel({
    this.success,
    // this.token,
    this.message,
    this.data,
  });

  ResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    // token = json['token'];
    message = json['message'] ?? 'bir hatalar varrr';
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    // json['token'] = token;
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
