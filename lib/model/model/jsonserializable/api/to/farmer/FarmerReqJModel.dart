import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FarmerReqJModel.g.dart';

@JsonSerializable()
class FarmerReqJModel {
  int? id;
  String? first_name;
  String? last_name;
  String? member_number;
  String? gender;
  String? phone_number;
  String? email;

  FarmerReqJModel() {}
  factory FarmerReqJModel.fromJson(Map<String, dynamic> json) =>
      _$FarmerReqJModelFromJson(json);
  Map<String, dynamic> toJson() => _$FarmerReqJModelToJson(this);
}
