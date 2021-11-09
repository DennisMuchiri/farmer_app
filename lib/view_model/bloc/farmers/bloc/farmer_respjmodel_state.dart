import 'package:equatable/equatable.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';

abstract class FarmerRespJModelState extends Equatable {
  const FarmerRespJModelState();
}

class FarmerRespJModelInitial extends FarmerRespJModelState {
  const FarmerRespJModelInitial();
  @override
  List<Object> get props => [];
}

class FarmerRespJModelLoading extends FarmerRespJModelState {
  const FarmerRespJModelLoading();
  @override
  List<Object> get props => [];
}

class FarmerRespJModelLoaded extends FarmerRespJModelState {
  final List<FarmerRespJModel> obj;
  const FarmerRespJModelLoaded(this.obj);
  @override
  List<Object> get props => [obj];
}
