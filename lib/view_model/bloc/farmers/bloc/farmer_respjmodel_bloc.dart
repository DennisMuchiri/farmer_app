import 'package:bloc/bloc.dart';
import 'package:farmer_app/view_model/bloc/farmers/bloc/farmer_respjmodel_bloc_event.dart';
import 'package:farmer_app/view_model/bloc/farmers/bloc/farmer_respjmodel_state.dart';
//import 'package:injectable/injectable.dart';

//@injectable
class FarmerRespJModelBloc
    extends Bloc<FarmerRespJModelEvent, FarmerRespJModelState> {
  FarmerRespJModelBloc() : super(FarmerRespJModelInitial());

  @override
  FarmerRespJModelState get initialState => FarmerRespJModelInitial();

  @override
  Stream<FarmerRespJModelState> mapEventToState(
    FarmerRespJModelEvent event,
  ) async* {
    if (event is ObjChanged) {
      final obj = (event.obj);
      yield FarmerRespJModelLoaded(obj);
    } else {
      yield FarmerRespJModelLoading();
    }
  }

  @override
  void dispose() {
    this.dispose();
  }
}
