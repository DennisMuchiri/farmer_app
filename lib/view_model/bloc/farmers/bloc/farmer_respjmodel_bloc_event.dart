
import 'package:equatable/equatable.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';


abstract class FarmerRespJModelEvent extends Equatable {
  const FarmerRespJModelEvent();
}

class ObjChanged extends FarmerRespJModelEvent {
  final List<FarmerRespJModel> obj;

  const ObjChanged(this.obj);

  @override
  List<Object> get props => [obj];
}
