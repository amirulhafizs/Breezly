class ApiModel {
  ApiModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  dynamic data;
  String? message;

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        success: json["success"],
        data: json["data"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "message": message,
      };

  initApiModel() {
    return ApiModel(success: false, data: {}, message: 'N/A');
  }
}
