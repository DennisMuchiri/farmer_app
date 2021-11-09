import 'package:equatable/equatable.dart';
import 'package:farmer_app/model/model/custom/NavigationData.dart';

abstract class NavigationdrawerState extends Equatable {
  const NavigationdrawerState();
}

class NavigationdrawerInitial extends NavigationdrawerState {
  const NavigationdrawerInitial();
  @override
  List<Object> get props => [];
}

class NavigationdrawerLoading extends NavigationdrawerState {
  const NavigationdrawerLoading();
  @override
  List<Object> get props => [];
}

class NavigationdrawerLoaded extends NavigationdrawerState {
  final NavigationData navigationData;
  const NavigationdrawerLoaded(this.navigationData);
  @override
  List<Object> get props => [navigationData];
}
