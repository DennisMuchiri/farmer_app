import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FarmerRespJModel.g.dart';

@JsonSerializable()
class FarmerRespJModel {
  int? id;
  int? onlineid;
  String? first_name;
  String? last_name;
  String? member_number;
  String? gender;
  String? phone_number;
  String? email;
  List<FarmRespJModel>? farms;

  //layout
  int? lv_index;
  bool? issettobeupdated;
  bool? deleted;

  FarmerRespJModel() {}
  factory FarmerRespJModel.fromJson(Map<String, dynamic> json) =>
      _$FarmerRespJModelFromJson(json);
  Map<String, dynamic> toJson() => _$FarmerRespJModelToJson(this);
}
