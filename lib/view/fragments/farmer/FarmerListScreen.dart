import 'dart:io';
import 'package:farmer_app/model/model/custom/NavigationData.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/model/repository/remote/chopper/functions/fetch/fetch_farmers.dart';
import 'package:farmer_app/utils/functions/common_functions.dart';
import 'package:farmer_app/utils/statics/farmer_app_static_params.dart';
import 'package:farmer_app/utils/themes/farmer_app_theme.dart';
import 'package:farmer_app/view/common/common_widgets.dart';
import 'package:farmer_app/view/custom/title/CustomTitleView.dart';
import 'package:farmer_app/view/fragments/farmer/FarmerCreateEditScreen.dart';
import 'package:farmer_app/view/fragments/farmer/listitems/FarmerListItem.dart';
import 'package:farmer_app/view_model/bloc/farmers/bloc/farmer_respjmodel_bloc.dart';
import 'package:farmer_app/view_model/bloc/farmers/bloc/farmer_respjmodel_state.dart';
import 'package:farmer_app/view_model/bloc/farmers/vms/farmer_list_viewmodel.dart';
import 'package:farmer_app/view_model/bloc/navigation/navigationdrawer_bloc.dart';
import 'package:farmer_app/view_model/bloc/navigation/navigationdrawer_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmerListScreen extends StatefulWidget {
  @override
  _FarmerListScreenState createState() => _FarmerListScreenState();
}

class _FarmerListScreenState extends State<FarmerListScreen>
    with TickerProviderStateMixin, AfterLayoutMixin<FarmerListScreen> {
  BuildContext? snackbarBuildContext;
  //animation
  AnimationController? _animationController;
  Animation<double>? _animation;

  //SMART REFRESHER
  RefreshController _refreshController = RefreshController();
  //END OF SMART REFRESHER

  //SCROLLING MAINPAGE LV
  ScrollController _scrollController = ScrollController();
  double _topBarOpacity = 0.0;
  //END OF SCROLLING MAIN PAGE LV

  //UI Inputs
  TextEditingController _searchTextEditingController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  //End of UI Inputs

  //state changers
  FarmerRespJModelBloc farmerRespJModelBloc = FarmerRespJModelBloc();
  FarmerListVM? _farmerListVM;
  //end of state changers

  @override
  void initState() {
    //animation
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));

    //add scroll controller listener
    _scrollController.addListener(() {
      if (_scrollController.offset >= 24) {
        if (_topBarOpacity != 1.0) {
          setState(() {
            _topBarOpacity = 1.0;
          });
        }
      } else if (_scrollController.offset <= 24 &&
          _scrollController.offset >= 0) {
        if (_topBarOpacity != _scrollController.offset / 24) {
          setState(() {
            _topBarOpacity = _scrollController.offset / 24;
          });
        }
      } else if (_scrollController.offset <= 0) {
        if (_topBarOpacity != 0.0) {
          setState(() {
            _topBarOpacity = 0.0;
          });
        }
      }
    });

    //set up viewmodels
    _farmerListVM = FarmerListVM(farmerRespJModelBloc: farmerRespJModelBloc);

    //enad of set up viewmodels

    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _setUpData(context);
  }

  //AFTER FIRST LAYOUT FUNCTIONS
  _setUpData(BuildContext context) async {
    //load data
    //this should be moved to it's own isolate
    await req_fetch_farmers(
      true,
      context,
    );
    print("_setUpData");
    _farmerListVM?.fetchFarmerslocal(context);
    //end of load data
  }
  //END OF AFTER FIRST LAYOUT FUNCTIONS

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FarmerAppTheme.bg_purple_light,
      child: Scaffold(
        backgroundColor: FarmerAppTheme.transparent,
        body: getMainListViewUI(),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: FarmerAppTheme.white.withOpacity(0.8),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FarmerAppTheme.lma_purple.withOpacity(0.4),
                    offset: Offset(8.0, 8.0),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  print('ADD CLICKED');
                  FarmerRespJModel farmerRespJModel = FarmerRespJModel();
                  _fn_on_FarmerListItem_Click(farmerRespJModel, null);
                },
                borderRadius: const BorderRadius.all(
                  Radius.circular(43.0),
                ),
                splashColor: FarmerAppTheme.grey,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Center(
                      child: Icon(
                    Icons.add,
                    size: 32,
                    color: FarmerAppTheme.lma_purple,
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //BUILD FUNCTION WIDGETS
  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
        future: common_wait_50ms(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          snackbarBuildContext = context;
          if (!snapshot.hasData) {
            return SizedBox();
          } else {
            _animationController!.forward();
            return Theme(
              data: ThemeData(primaryColor: FarmerAppTheme.lma_purple),
              child: SmartRefresher(
                onRefresh: () async {
                  _refreshController.refreshCompleted();
                },
                enablePullUp: true,
                onLoading: () async {
                  _refreshController.loadComplete();
                },
                controller: _refreshController,
                enablePullDown: true,
                header: WaterDropMaterialHeader(
                    backgroundColor: FarmerAppTheme.white,
                    color: FarmerAppTheme.lma_purple,
                    distance: 30),
                footer: ClassicFooter(
                  loadStyle: LoadStyle.ShowWhenLoading,
                  textStyle: TextStyle(
                    fontFamily: FarmerAppTheme.font_AvenirLTStd_Book,
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    letterSpacing: -0.2,
                    color: FarmerAppTheme.grey,
                  ),
                  completeDuration: Duration(milliseconds: 500),
                  loadingIcon: SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: Platform.isIOS
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                  idleIcon: Icon(
                    Icons.sync,
                    color: FarmerAppTheme.grey,
                  ),
                  canLoadingIcon: Icon(
                    Icons.arrow_upward,
                    color: FarmerAppTheme.grey,
                  ),
                ),
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: //MediaQuery.of(context).padding.top,
                        AppBar().preferredSize.height +
                            MediaQuery.of(context).padding.top +
                            24,
                    bottom: 62,
                  ),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    CustomTitleView(
                      titleTxt: 'Farmers',
                      subTxt: '',
                      animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: _animationController!,
                              curve: Interval(
                                  (1 /
                                          FarmerAppStaticParams
                                              .mainui_lv_itemscount) *
                                      0,
                                  1.0,
                                  curve: Curves.fastOutSlowIn))),
                      animationController: _animationController,
                      titleTextStyle: TextStyle(
                        fontFamily: FarmerAppTheme.font_AvenirLTStd_Heavy,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        letterSpacing: 0.5,
                        color: FarmerAppTheme.lma_purple_2,
                      ),
                    ),
                    _searchField(),
                    BlocBuilder<FarmerRespJModelBloc, FarmerRespJModelState>(
                        bloc: farmerRespJModelBloc,
                        builder: (context, st) {
                          if (st is FarmerRespJModelLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: st.obj.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return FarmerListItem(
                                  animationController: _animationController,
                                  farmerListItemCallback:
                                      _fn_on_FarmerListItem_Click,
                                  index: index,
                                  farmerRespJModel: st.obj[index],
                                  farmerListItemDeleteCallback:
                                      _fn_on_FarmerListItem_Delete_Click,
                                );
                              },
                            );
                          } else {
                            return invisibleWidget();
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget _searchField() {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: _animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - _animation!.value), 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 0, bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 16, top: 8, bottom: 0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: FarmerAppTheme.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    offset: Offset(0, 2),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 0, bottom: 0),
                              child: TextField(
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily:
                                      FarmerAppTheme.font_AvenirLTStd_Medium,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: 0.0,
                                  color: FarmerAppTheme.darkText,
                                ),
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.search,
                                      size: 24, color: FarmerAppTheme.grey),
                                  border: InputBorder.none,
                                  hintText: 'Search farmer',
                                  hintStyle: TextStyle(
                                    fontFamily:
                                        FarmerAppTheme.font_AvenirLTStd_Book,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    letterSpacing: 0.0,
                                    color: FarmerAppTheme.grey.withOpacity(0.7),
                                  ),
                                ),
                                controller: _searchTextEditingController,
                                cursorColor: FarmerAppTheme.grey,
                                focusNode: _searchFocusNode,
                                autofocus: false,
                                onTap: () {},
                                onChanged: (String txt) {
                                  print(' _searchTextEditingController.text');
                                  print(_searchTextEditingController.text);
                                  _farmerListVM?.searchFarmerslocal(
                                    _searchTextEditingController.text,
                                    context,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*Container(
                        decoration: BoxDecoration(
                          color: FarmerAppTheme.white.withOpacity(0.8),
                          borderRadius: BorderRadius.all(
                            Radius.circular(43.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: FarmerAppTheme.nearlyBlack
                                    .withOpacity(0.4),
                                offset: Offset(0, 2),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(43.0),
                            ),
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.all(11.0),
                              child: Icon(Icons.search,
                                  size: 24, color: FarmerAppTheme.grey),
                            ),
                          ),
                        ),
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  //END OF BUILD FUNCTION WIDGETS

  //build widget actions
  _fn_on_FarmerListItem_Click(
    FarmerRespJModel farmerRespJModel,
    int? index,
  ) {
    NavigationData navigationData = new NavigationData();
    navigationData.selectedWidget = FarmerCreateEditScreen(
      farmerRespJModel: farmerRespJModel,
    );
    navigationData.isInBackPressed = false;
    NavigationdrawerBloc navigationdrawerBloc =
        BlocProvider.of<NavigationdrawerBloc>(context);
    navigationdrawerBloc.add(NavDrawer(navigationData));
  }

  _fn_on_FarmerListItem_Delete_Click(
    FarmerRespJModel farmerRespJModel,
    int? index,
  ) async {
    //delete  farmer
    await _farmerListVM?.deleteFarmerlocal(farmerRespJModel.id!, context);
    _farmerListVM?.fetchFarmerslocal(context);
  }
  //end of build widget actions

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController?.dispose();
    }
    super.dispose();
  }
}
