import 'package:equatable/equatable.dart';

class CommonResponseModel extends Equatable {
  final int statusCode;
  final String message;
  const CommonResponseModel({
    required this.statusCode,
    required this.message,

  });

  @override
  List<Object?> get props => [statusCode, message];

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
    );
  }
}