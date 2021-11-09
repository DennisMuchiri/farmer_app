
import 'package:equatable/equatable.dart';
import 'package:farmer_app/model/model/custom/NavigationData.dart';

abstract class NavigationdrawerEvent extends Equatable {
  const NavigationdrawerEvent();
}

class NavDrawer extends NavigationdrawerEvent {
  final NavigationData navigationData;

  const NavDrawer(this.navigationData);

  @override
  List<Object> get props => [navigationData];
}
