import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:farmer_app/view_model/bloc/navigation/navigationdrawer_event.dart';
import 'package:farmer_app/view_model/bloc/navigation/navigationdrawer_state.dart';

class NavigationdrawerBloc
    extends Bloc<NavigationdrawerEvent, NavigationdrawerState> {
  NavigationdrawerBloc() : super(NavigationdrawerInitial());

  @override
  NavigationdrawerState get initialState => NavigationdrawerInitial();

  @override
  Stream<NavigationdrawerState> mapEventToState(
    NavigationdrawerEvent event,
  ) async* {
    yield NavigationdrawerLoading();
    if (event is NavDrawer) {
      final navigationData = (event.navigationData);
      yield NavigationdrawerLoaded(navigationData);
    }
  }

  @override
  void dispose() {
    this.dispose();
  }
}
