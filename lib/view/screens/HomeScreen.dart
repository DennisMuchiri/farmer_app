import 'dart:io';

import 'package:farmer_app/injection/injection.dart';
import 'package:farmer_app/model/model/custom/NavigationData.dart';
import 'package:farmer_app/utils/enums/screens.dart';
import 'package:farmer_app/utils/themes/farmer_app_theme.dart';
import 'package:farmer_app/view/fragments/farmer/FarmerListScreen.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_bloc.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_event.dart';
import 'package:farmer_app/view_model/bloc/navigation/navigationdrawer_bloc.dart';
import 'package:farmer_app/view_model/bloc/navigation/navigationdrawer_event.dart';
import 'package:farmer_app/view_model/bloc/navigation/navigationdrawer_state.dart';
import 'package:farmer_app/view_model/counter/CounterChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  Object? screenView = FarmerListScreen();
  ScreenIndex? screenIndex;

  //stste variables
  List<Object> widgetsHistory = [];

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Container(
        color: FarmerAppTheme.bg_purple_light,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: FarmerAppTheme.bg_purple_light,
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                decoration: BoxDecoration(
                  color: FarmerAppTheme.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FarmerAppTheme.grey.withOpacity(0.6),
                        blurRadius: 24),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    BlocListener<NavigationdrawerBloc, NavigationdrawerState>(
                      listener: (context, state) {},
                      child: BlocBuilder<NavigationdrawerBloc,
                          NavigationdrawerState>(
                        builder: (context, state) {
                          if (state is NavigationdrawerLoaded) {
                            NavigationData navigationData =
                                state.navigationData;
                            screenView = navigationData.selectedWidget;
                            if (navigationData.screenIndex != null) {
                              screenIndex = navigationData.screenIndex;
                            }
                            if (navigationData.isInBackPressed != null &&
                                !navigationData.isInBackPressed!) {
                              if (screenView is FarmerListScreen) {
                              } else {
                                _ifToAddWidgetToHistory(screenView);
                              }
                            }
                            return screenView as Widget;
                          } else if (state is NavigationdrawerInitial) {
                            _ifToAddWidgetToHistory(screenView);
                            return screenView as Widget;
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Build widget functions
  _ifToAddWidgetToHistory(Object? widgetToadd) {
    String TAG = 'ifToAddWidgetToHistory:';
    if (widgetsHistory != null) {
      List<Object> widgetsFoudMatching = [];
      for (Object widgetsHistoryItem in widgetsHistory) {
        if (widgetsHistoryItem.runtimeType.toString() ==
            widgetToadd.runtimeType.toString()) {
          widgetsFoudMatching.add(widgetsHistoryItem);
        }
      }
      if (widgetsFoudMatching.length > 0) {
      } else {
        widgetsHistory.add(widgetToadd!);
      }
    }
  }

  _onBackPressed(BuildContext context) {
    String TAG = '_onBackPressed:';

    if (widgetsHistory.length > 0) {
      List<Object> updatedWidgetHistoryState = [];
      updatedWidgetHistoryState.addAll(widgetsHistory);

      Object currentWidget = widgetsHistory[widgetsHistory.length - 1];
      updatedWidgetHistoryState.remove(currentWidget);

      if (updatedWidgetHistoryState.length > 0) {
        Object openingWidget = widgetsHistory[widgetsHistory.length - 2];

        NavigationData navigationData = new NavigationData();
        navigationData.selectedWidget = openingWidget;
        navigationData.isInBackPressed = true;
        NavigationdrawerBloc navigationdrawerBloc =
            BlocProvider.of<NavigationdrawerBloc>(context);
        navigationdrawerBloc.add(NavDrawer(navigationData));

        widgetsHistory.remove(currentWidget);
      } else {
        return _asyncPop(context);
      }
    } else {
      return _asyncPop(context);
    }
  }

  Future<bool> _asyncPop(BuildContext context) async {
    String TAG = 'asyncPop:';
    if (Platform.isIOS) {
      return false;
    } else {
      //bool afterPop = await Navigator.of(context).pop();
      bool afterPop = Navigator.of(context).canPop();
      if (afterPop) {
        Navigator.of(context).pop();
        return afterPop;
      } else {
        Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
        return true;
      }
    }
  }
  //end of Build Widget functions
}
