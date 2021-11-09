import 'dart:async';

import 'package:farmer_app/model/model/custom/NavigationData.dart';

import 'NavigationDataEvent.dart';

class NavigationDataBLoC {
  final _navigationDataStreamController =
      StreamController<NavigationData>.broadcast();
  StreamSink<NavigationData> get navigationData_sink =>
      _navigationDataStreamController.sink;

  Stream<NavigationData> get stream_counter =>
      _navigationDataStreamController.stream;

  final _navigationDataEventController =
      StreamController<NavigationDataEvent>();
  Sink<NavigationDataEvent> get dailySubTaskimages_event_sink =>
      _navigationDataEventController.sink;

  NavigationDataBLoC() {
    _navigationDataEventController.stream.listen(_navigationData);
  }

  _navigationData(NavigationDataEvent event) {
    if (event is NavigationDataAddedEvent) {
      NavigationData navigationData = event.navigationData;
      navigationData_sink.add(navigationData);
    }
  }

  dispose() {
    _navigationDataStreamController.close();
    _navigationDataEventController.close();
  }
}
