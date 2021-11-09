import 'package:farmer_app/model/model/custom/NavigationData.dart';

abstract class NavigationDataEvent {
  const NavigationDataEvent();
}

class NavigationDataAddedEvent extends NavigationDataEvent {
  final NavigationData navigationData;
  const NavigationDataAddedEvent(this.navigationData);
}
