import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/to/farmer/FarmReqJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/to/farmer/FarmerReqJModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FarmerSyncReqJModel.g.dart';

@JsonSerializable()
class FarmerSyncReqJModel {
  @JsonKey(includeIfNull: false)
  List<FarmerReqJModel>? new_farmers;
  @JsonKey(includeIfNull: false)
  List<FarmerReqJModel>? updated_farmers;
  @JsonKey(includeIfNull: false)
  List<FarmerReqJModel>? deleted_farmers;

  @JsonKey(includeIfNull: false)
  List<FarmReqJModel>? new_farms;
  @JsonKey(includeIfNull: false)
  List<FarmReqJModel>? updated_farms;
  @JsonKey(includeIfNull: false)
  List<FarmReqJModel>? delete_farms;

  FarmerSyncReqJModel() {}
  factory FarmerSyncReqJModel.fromJson(Map<String, dynamic> json) =>
      _$FarmerSyncReqJModelFromJson(json);
  Map<String, dynamic> toJson() => _$FarmerSyncReqJModelToJson(this);
}
