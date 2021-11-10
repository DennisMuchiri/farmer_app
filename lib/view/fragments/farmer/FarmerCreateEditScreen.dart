import 'dart:io';
import 'package:farmer_app/model/model/custom/NavigationData.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/model/repository/remote/chopper/functions/fetch/fetch_farmers.dart';
import 'package:farmer_app/utils/functions/common_functions.dart';
import 'package:farmer_app/utils/functions/validators.dart';
import 'package:farmer_app/utils/statics/farmer_app_static_params.dart';
import 'package:farmer_app/utils/themes/farmer_app_theme.dart';
import 'package:farmer_app/view/common/common_widgets.dart';
import 'package:farmer_app/view/custom/columnbuilder/column_builder.dart';
import 'package:farmer_app/view/custom/title/CustomTitleView.dart';
import 'package:farmer_app/view/dialogs/AddFarmDialog.dart';
import 'package:farmer_app/view/fragments/farmer/listitems/FarmListItem.dart';
import 'package:farmer_app/view/fragments/farmer/listitems/FarmerListItem.dart';
import 'package:farmer_app/view_model/bloc/farmers/bloc/farmer_respjmodel_bloc.dart';
import 'package:farmer_app/view_model/bloc/farmers/bloc/farmer_respjmodel_state.dart';
import 'package:farmer_app/view_model/bloc/farmers/vms/farm_viewmodel.dart';
import 'package:farmer_app/view_model/bloc/farmers/vms/farmer_list_viewmodel.dart';
import 'package:farmer_app/view_model/bloc/farms/bloc/farm_respjmodel_bloc.dart';
import 'package:farmer_app/view_model/bloc/farms/bloc/farm_respjmodel_state.dart';
import 'package:farmer_app/view_model/streams/navdata/NavigationDataBLoC.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmerCreateEditScreen extends StatefulWidget {
  FarmerRespJModel farmerRespJModel;

  FarmerCreateEditScreen({
    Key? key,
    required this.farmerRespJModel,
  }) : super(key: key);

  @override
  _FarmerCreateEditScreenState createState() => _FarmerCreateEditScreenState();
}

class _FarmerCreateEditScreenState extends State<FarmerCreateEditScreen>
    with TickerProviderStateMixin, AfterLayoutMixin<FarmerCreateEditScreen> {
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
  FarmRespJModelBloc farmRespJModelBloc = FarmRespJModelBloc();
  FarmListVM? _farmListVM;
  //end of state changers

  //fields
  //fname
  TextEditingController _fname_txt_Controller = TextEditingController();
  FocusNode _fname_FocusNode = FocusNode();
  NavigationDataBLoC _wd_fname_Container_NavigationDataBLoC =
      NavigationDataBLoC();
  //lname
  TextEditingController _lname_txt_Controller = TextEditingController();
  FocusNode _lname_FocusNode = FocusNode();
  NavigationDataBLoC _wd_lname_Container_NavigationDataBLoC =
      NavigationDataBLoC();

  //memberno
  TextEditingController _memberno_txt_Controller = TextEditingController();
  FocusNode _memberno_FocusNode = FocusNode();
  NavigationDataBLoC _wd_memberno_Container_NavigationDataBLoC =
      NavigationDataBLoC();

  //gender
  TextEditingController _gender_txt_Controller = TextEditingController();
  FocusNode _gender_FocusNode = FocusNode();
  NavigationDataBLoC _wd_gender_Container_NavigationDataBLoC =
      NavigationDataBLoC();

  //phone
  TextEditingController _phone_txt_Controller = TextEditingController();
  FocusNode _phone_FocusNode = FocusNode();
  NavigationDataBLoC _wd_phone_Container_NavigationDataBLoC =
      NavigationDataBLoC();

  //email
  TextEditingController _email_txt_Controller = TextEditingController();
  FocusNode _email_FocusNode = FocusNode();
  NavigationDataBLoC _wd_email_Container_NavigationDataBLoC =
      NavigationDataBLoC();

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
    _farmListVM = FarmListVM(farmRespJModelBloc: farmRespJModelBloc);

    //enad of set up viewmodels

    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _setUpData(context);
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController?.dispose();
    }
    super.dispose();
  }

  //AFTER FIRST LAYOUT FUNCTIONS
  _setUpData(BuildContext context) async {
    //load data
    if (isStringValid(widget.farmerRespJModel.first_name)) {
      _fname_txt_Controller.text = widget.farmerRespJModel.first_name!;
    }
    if (isStringValid(widget.farmerRespJModel.last_name)) {
      _lname_txt_Controller.text = widget.farmerRespJModel.last_name!;
    }

    if (isStringValid(widget.farmerRespJModel.member_number)) {
      _memberno_txt_Controller.text = widget.farmerRespJModel.member_number!;
    }

    if (isStringValid(widget.farmerRespJModel.gender)) {
      _gender_txt_Controller.text = widget.farmerRespJModel.gender!;
    }

    if (isStringValid(widget.farmerRespJModel.phone_number)) {
      _phone_txt_Controller.text = widget.farmerRespJModel.phone_number!;
    }

    if (isStringValid(widget.farmerRespJModel.email)) {
      _email_txt_Controller.text = widget.farmerRespJModel.email!;
    }

    if (widget.farmerRespJModel.id != null) {
      _farmListVM?.fetchFarmsFromFarmerlocal(
          widget.farmerRespJModel.id!, context);
    }
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
                  print('Save CLICKED');
                },
                borderRadius: const BorderRadius.all(
                  Radius.circular(43.0),
                ),
                splashColor: FarmerAppTheme.grey,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Center(
                      child: Icon(
                    Icons.save,
                    size: 32,
                    color: FarmerAppTheme.lma_purple_2,
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    /* ListView(
                    controller: _scrollController,
                    shrinkWrap: false,
                    padding: EdgeInsets.only(
                      top: //MediaQuery.of(context).padding.top,
                          AppBar().preferredSize.height +
                              MediaQuery.of(context).padding.top +
                              24,
                      bottom: 62,
                    ),
                    scrollDirection: Axis.vertical,*/
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: AppBar().preferredSize.height +
                            //MediaQuery.of(context).padding.top +
                            24,
                        bottom: 62,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTitleView(
                            titleTxt: 'Farmer details',
                            subTxt: '',
                            animation: Tween<double>(begin: 0.0, end: 1.0)
                                .animate(CurvedAnimation(
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
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 0),
                            child: Text(
                              'First name',
                              style: TextStyle(
                                fontFamily:
                                    FarmerAppTheme.font_AvenirLTStd_Medium,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: FarmerAppTheme.grey,
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: FarmerAppTheme.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              offset: const Offset(0.3, 2),
                                              blurRadius: 4.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                            top: 0,
                                            bottom: 0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          style: TextStyle(
                                            fontFamily: FarmerAppTheme
                                                .font_AvenirLTStd_Medium,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FarmerAppTheme.darkText,
                                          ),
                                          cursorColor:
                                              Colors.grey.withOpacity(0.6),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "First name",
                                            hintStyle: TextStyle(
                                              fontFamily: FarmerAppTheme
                                                  .font_AvenirLTStd_Book,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FarmerAppTheme.darkText,
                                            ),
                                            errorStyle: TextStyle(
                                                color: FarmerAppTheme.red,
                                                fontSize: 12.0,
                                                fontFamily: FarmerAppTheme
                                                    .font_AvenirLTStd_Light),
                                            prefixIcon: Icon(
                                              Icons.edit,
                                              color: FarmerAppTheme.darkText,
                                              size: 15.0,
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (String val) {
                                            _fnameChanged(val);
                                          },
                                          controller: _fname_txt_Controller,
                                          focusNode: _fname_FocusNode,
                                          autofocus: false,
                                          onFieldSubmitted: (String val) {
                                            _fname_FocusNode.unfocus();
                                          },
                                        ),
                                      ),
                                    )),
                                  ]),
                                  StreamBuilder(
                                    stream:
                                        _wd_fname_Container_NavigationDataBLoC
                                            .stream_counter,
                                    builder: (context,
                                        AsyncSnapshot<NavigationData>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return invisibleWidget();
                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return invisibleWidget();
                                        case ConnectionState.waiting:
                                          return invisibleWidget();
                                        case ConnectionState.active:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                        case ConnectionState.done:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                      }
                                    },
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 5, bottom: 0),
                            child: Text(
                              'Last name',
                              style: TextStyle(
                                fontFamily:
                                    FarmerAppTheme.font_AvenirLTStd_Medium,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: FarmerAppTheme.grey,
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: FarmerAppTheme.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              offset: const Offset(0.3, 2),
                                              blurRadius: 4.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                            top: 0,
                                            bottom: 0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          style: TextStyle(
                                            fontFamily: FarmerAppTheme
                                                .font_AvenirLTStd_Medium,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FarmerAppTheme.darkText,
                                          ),
                                          cursorColor:
                                              Colors.grey.withOpacity(0.6),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Last name",
                                            hintStyle: TextStyle(
                                              fontFamily: FarmerAppTheme
                                                  .font_AvenirLTStd_Book,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FarmerAppTheme.darkText,
                                            ),
                                            errorStyle: TextStyle(
                                                color: FarmerAppTheme.red,
                                                fontSize: 12.0,
                                                fontFamily: FarmerAppTheme
                                                    .font_AvenirLTStd_Light),
                                            prefixIcon: Icon(
                                              Icons.edit,
                                              color: FarmerAppTheme.darkText,
                                              size: 15.0,
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (String val) {
                                            _lnameChanged(val);
                                          },
                                          controller: _lname_txt_Controller,
                                          focusNode: _lname_FocusNode,
                                          autofocus: false,
                                          onFieldSubmitted: (String val) {
                                            _lname_FocusNode.unfocus();
                                          },
                                        ),
                                      ),
                                    )),
                                  ]),
                                  StreamBuilder(
                                    stream:
                                        _wd_lname_Container_NavigationDataBLoC
                                            .stream_counter,
                                    builder: (context,
                                        AsyncSnapshot<NavigationData>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return invisibleWidget();
                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return invisibleWidget();
                                        case ConnectionState.waiting:
                                          return invisibleWidget();
                                        case ConnectionState.active:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                        case ConnectionState.done:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                      }
                                    },
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 5, bottom: 0),
                            child: Text(
                              'Member No',
                              style: TextStyle(
                                fontFamily:
                                    FarmerAppTheme.font_AvenirLTStd_Medium,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: FarmerAppTheme.grey,
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: FarmerAppTheme.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              offset: const Offset(0.3, 2),
                                              blurRadius: 4.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                            top: 0,
                                            bottom: 0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          style: TextStyle(
                                            fontFamily: FarmerAppTheme
                                                .font_AvenirLTStd_Medium,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FarmerAppTheme.darkText,
                                          ),
                                          cursorColor:
                                              Colors.grey.withOpacity(0.6),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Member No",
                                            hintStyle: TextStyle(
                                              fontFamily: FarmerAppTheme
                                                  .font_AvenirLTStd_Book,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FarmerAppTheme.darkText,
                                            ),
                                            errorStyle: TextStyle(
                                                color: FarmerAppTheme.red,
                                                fontSize: 12.0,
                                                fontFamily: FarmerAppTheme
                                                    .font_AvenirLTStd_Light),
                                            prefixIcon: Icon(
                                              Icons.edit,
                                              color: FarmerAppTheme.darkText,
                                              size: 15.0,
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (String val) {
                                            _membernoChanged(val);
                                          },
                                          controller: _memberno_txt_Controller,
                                          focusNode: _memberno_FocusNode,
                                          autofocus: false,
                                          onFieldSubmitted: (String val) {
                                            _memberno_FocusNode.unfocus();
                                          },
                                        ),
                                      ),
                                    )),
                                  ]),
                                  StreamBuilder(
                                    stream:
                                        _wd_memberno_Container_NavigationDataBLoC
                                            .stream_counter,
                                    builder: (context,
                                        AsyncSnapshot<NavigationData>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return invisibleWidget();
                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return invisibleWidget();
                                        case ConnectionState.waiting:
                                          return invisibleWidget();
                                        case ConnectionState.active:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                        case ConnectionState.done:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                      }
                                    },
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 5, bottom: 0),
                            child: Text(
                              'Gender',
                              style: TextStyle(
                                fontFamily:
                                    FarmerAppTheme.font_AvenirLTStd_Medium,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: FarmerAppTheme.grey,
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: FarmerAppTheme.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              offset: const Offset(0.3, 2),
                                              blurRadius: 4.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                            top: 0,
                                            bottom: 0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          style: TextStyle(
                                            fontFamily: FarmerAppTheme
                                                .font_AvenirLTStd_Medium,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FarmerAppTheme.darkText,
                                          ),
                                          cursorColor:
                                              Colors.grey.withOpacity(0.6),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Gender",
                                            hintStyle: TextStyle(
                                              fontFamily: FarmerAppTheme
                                                  .font_AvenirLTStd_Book,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FarmerAppTheme.darkText,
                                            ),
                                            errorStyle: TextStyle(
                                                color: FarmerAppTheme.red,
                                                fontSize: 12.0,
                                                fontFamily: FarmerAppTheme
                                                    .font_AvenirLTStd_Light),
                                            prefixIcon: Icon(
                                              Icons.edit,
                                              color: FarmerAppTheme.darkText,
                                              size: 15.0,
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (String val) {
                                            _genderChanged(val);
                                          },
                                          controller: _gender_txt_Controller,
                                          focusNode: _gender_FocusNode,
                                          autofocus: false,
                                          onFieldSubmitted: (String val) {
                                            _gender_FocusNode.unfocus();
                                          },
                                        ),
                                      ),
                                    )),
                                  ]),
                                  StreamBuilder(
                                    stream:
                                        _wd_gender_Container_NavigationDataBLoC
                                            .stream_counter,
                                    builder: (context,
                                        AsyncSnapshot<NavigationData>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return invisibleWidget();
                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return invisibleWidget();
                                        case ConnectionState.waiting:
                                          return invisibleWidget();
                                        case ConnectionState.active:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                        case ConnectionState.done:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                      }
                                    },
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 5, bottom: 0),
                            child: Text(
                              'Phone No',
                              style: TextStyle(
                                fontFamily:
                                    FarmerAppTheme.font_AvenirLTStd_Medium,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: FarmerAppTheme.grey,
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: FarmerAppTheme.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              offset: const Offset(0.3, 2),
                                              blurRadius: 4.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                            top: 0,
                                            bottom: 0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          style: TextStyle(
                                            fontFamily: FarmerAppTheme
                                                .font_AvenirLTStd_Medium,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FarmerAppTheme.darkText,
                                          ),
                                          cursorColor:
                                              Colors.grey.withOpacity(0.6),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Phone No",
                                            hintStyle: TextStyle(
                                              fontFamily: FarmerAppTheme
                                                  .font_AvenirLTStd_Book,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FarmerAppTheme.darkText,
                                            ),
                                            errorStyle: TextStyle(
                                                color: FarmerAppTheme.red,
                                                fontSize: 12.0,
                                                fontFamily: FarmerAppTheme
                                                    .font_AvenirLTStd_Light),
                                            prefixIcon: Icon(
                                              Icons.edit,
                                              color: FarmerAppTheme.darkText,
                                              size: 15.0,
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (String val) {
                                            _phoneChanged(val);
                                          },
                                          controller: _phone_txt_Controller,
                                          focusNode: _phone_FocusNode,
                                          autofocus: false,
                                          onFieldSubmitted: (String val) {
                                            _phone_FocusNode.unfocus();
                                          },
                                        ),
                                      ),
                                    )),
                                  ]),
                                  StreamBuilder(
                                    stream:
                                        _wd_phone_Container_NavigationDataBLoC
                                            .stream_counter,
                                    builder: (context,
                                        AsyncSnapshot<NavigationData>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return invisibleWidget();
                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return invisibleWidget();
                                        case ConnectionState.waiting:
                                          return invisibleWidget();
                                        case ConnectionState.active:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                        case ConnectionState.done:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                      }
                                    },
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 5, bottom: 0),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontFamily:
                                    FarmerAppTheme.font_AvenirLTStd_Medium,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: FarmerAppTheme.grey,
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        color: FarmerAppTheme.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              offset: const Offset(0.3, 2),
                                              blurRadius: 4.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4,
                                            right: 4,
                                            top: 0,
                                            bottom: 0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          style: TextStyle(
                                            fontFamily: FarmerAppTheme
                                                .font_AvenirLTStd_Medium,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FarmerAppTheme.darkText,
                                          ),
                                          cursorColor:
                                              Colors.grey.withOpacity(0.6),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            hintStyle: TextStyle(
                                              fontFamily: FarmerAppTheme
                                                  .font_AvenirLTStd_Book,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FarmerAppTheme.darkText,
                                            ),
                                            errorStyle: TextStyle(
                                                color: FarmerAppTheme.red,
                                                fontSize: 12.0,
                                                fontFamily: FarmerAppTheme
                                                    .font_AvenirLTStd_Light),
                                            prefixIcon: Icon(
                                              Icons.edit,
                                              color: FarmerAppTheme.darkText,
                                              size: 15.0,
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (String val) {
                                            _emailChanged(val);
                                          },
                                          controller: _email_txt_Controller,
                                          focusNode: _email_FocusNode,
                                          autofocus: false,
                                          onFieldSubmitted: (String val) {
                                            _email_FocusNode.unfocus();
                                          },
                                        ),
                                      ),
                                    )),
                                  ]),
                                  StreamBuilder(
                                    stream:
                                        _wd_email_Container_NavigationDataBLoC
                                            .stream_counter,
                                    builder: (context,
                                        AsyncSnapshot<NavigationData>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return invisibleWidget();
                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return invisibleWidget();
                                        case ConnectionState.waiting:
                                          return invisibleWidget();
                                        case ConnectionState.active:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                        case ConnectionState.done:
                                          return wd_Text_Widget_Form_Validator_Text(
                                              snapshot);
                                      }
                                    },
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 5, bottom: 0),
                            child: Text(
                              'Farms',
                              style: TextStyle(
                                fontFamily:
                                    FarmerAppTheme.font_AvenirLTStd_Medium,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.0,
                                color: FarmerAppTheme.lma_purple_2,
                              ),
                            ),
                          ),
                          BlocBuilder<FarmRespJModelBloc, FarmRespJModelState>(
                              bloc: farmRespJModelBloc,
                              builder: (context, st) {
                                if (st is FarmRespJModelLoaded) {
                                  return ColumnBuilder(
                                      itemCount: st.obj.length,
                                      mainAxisSize: MainAxisSize.min,
                                      itemBuilder: (context, index) {
                                        return FarmListItem(
                                          animationController:
                                              _animationController,
                                          farmerListItemCallback:
                                              _fn_on_FarmListItem_Click,
                                          index: index,
                                          farmRespJModel: st.obj[index],
                                          farmListItemDeleteCallback:
                                              _fn_on_FarmListItem_Delete_Click,
                                        );
                                      });
                                  /*return ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: st.obj.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return FarmListItem(
                                        animationController:
                                            _animationController,
                                        farmerListItemCallback:
                                            _fn_on_FarmListItem_Click,
                                        index: index,
                                        farmRespJModel: st.obj[index],
                                        farmListItemDeleteCallback:
                                            _fn_on_FarmListItem_Delete_Click,
                                      );
                                    },
                                  );*/
                                } else {
                                  return invisibleWidget();
                                }
                              }),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      print('add vehicle');
                                      FarmRespJModel farmRespJModel =
                                          FarmRespJModel();
                                      farmRespJModel.farmer =
                                          widget.farmerRespJModel.id;
                                      _addFarm(
                                        context,
                                        farmRespJModel,
                                      );
                                    },
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(43.0),
                                    ),
                                    splashColor: FarmerAppTheme.lma_blue_1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FarmerAppTheme.lma_purple
                                            .withOpacity(0.8),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: FarmerAppTheme.lma_purple_2
                                                  .withOpacity(0.4),
                                              offset: Offset(7.0, 7.0),
                                              blurRadius: 7.0),
                                        ],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(3.0),
                                            bottomLeft: Radius.circular(3.0),
                                            bottomRight: Radius.circular(3.0),
                                            topRight: Radius.circular(3.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 3,
                                          bottom: 3,
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Add farm',
                                              style: TextStyle(
                                                color: FarmerAppTheme.white,
                                                fontFamily: FarmerAppTheme
                                                    .font_AvenirLTStd_Medium,
                                              ),
                                            ),
                                            Icon(
                                              Icons.add,
                                              size: 17,
                                              color: FarmerAppTheme.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          }
        });
  }

  //END OF BUILD FUNCTION WIDGETS

  //build widget actions
  //data getters
  _fnameChanged(String txt) {}
  _lnameChanged(String txt) {}
  _membernoChanged(String txt) {}
  _genderChanged(String txt) {}
  _phoneChanged(String txt) {}
  _emailChanged(String txt) {}
  //end of data getters
  _fn_on_FarmListItem_Click(
    FarmRespJModel farmerRespJModel,
    int? index,
  ) {
    //edit existing farm
    _addFarm(
      context,
      farmerRespJModel,
    );
  }

  _fn_on_FarmListItem_Delete_Click(
    FarmRespJModel farmerRespJModel,
    int? index,
  ) async {
    //delete  farm
    await _farmListVM?.deleteFarmlocal(farmerRespJModel.id!, context);
    _farmListVM?.fetchFarmsFromFarmerlocal(
        widget.farmerRespJModel.id!, context);
  }

  _addFarm(
    BuildContext context,
    FarmRespJModel farmRespJModel,
  ) async {
    FarmRespJModel? saved_FarmRespJModel = await showGeneralDialog(
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: Duration(milliseconds: 150),
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AddFarmDialog(
            snackbarBuildContext: snackbarBuildContext,
            farm: farmRespJModel,
          );
        });
    if (saved_FarmRespJModel != null) {
      print("saved_FarmRespJModel");
      if (widget.farmerRespJModel.id != null) {
        print("widget.farmerRespJModel.id != null");
        _farmListVM?.fetchFarmsFromFarmerlocal(
            widget.farmerRespJModel.id!, context);
      }
    } else {
      print("!saved_FarmRespJModel");
    }
  }
}
//end of build widget actions
