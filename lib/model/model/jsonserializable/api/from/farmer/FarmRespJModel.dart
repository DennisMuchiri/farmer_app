import 'package:json_annotation/json_annotation.dart';

part 'FarmRespJModel.g.dart';

@JsonSerializable()
class FarmRespJModel {
  int? id;
  int? onlineid;
  int? farmer_online_id;
  String? farm_name;
  String? farm_size;

  //layout
  int? lv_index;
  int? farmer;
  bool? issettobeupdated;
  bool? deleted;

  //FarmRespJModel() {}
  FarmRespJModel({bool? deleted}) : deleted = deleted ?? false;

  factory FarmRespJModel.fromJson(Map<String, dynamic> json) =>
      _$FarmRespJModelFromJson(json);
  Map<String, dynamic> toJson() => _$FarmRespJModelToJson(this);
}
