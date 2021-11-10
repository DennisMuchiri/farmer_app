import 'dart:async';
import 'dart:convert';

import 'package:farmer_app/model/model/custom/NavigationData.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';
import 'package:farmer_app/utils/functions/common_functions.dart';
import 'package:farmer_app/utils/functions/validators.dart';
import 'package:farmer_app/utils/themes/farmer_app_theme.dart';
import 'package:farmer_app/view/common/common_widgets.dart';
import 'package:farmer_app/view_model/bloc/farmers/vms/farm_viewmodel.dart';
import 'package:farmer_app/view_model/streams/navdata/NavigationDataBLoC.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddFarmDialog extends StatefulWidget {
  BuildContext? snackbarBuildContext;
  @required
  FarmRespJModel farm;

  AddFarmDialog({
    Key? key,
    this.snackbarBuildContext,
    required this.farm,
  }) : super(key: key);
  @override
  _AddFarmDialogState createState() => new _AddFarmDialogState();
}

class _AddFarmDialogState extends State<AddFarmDialog>
    with TickerProviderStateMixin, AfterLayoutMixin<AddFarmDialog> {
  List<String> str = [];
  AnimationController? _animationController;
  Animation<double>? animation;

  //name
  TextEditingController _name_txt_Controller = TextEditingController();
  FocusNode _name_FocusNode = FocusNode();
  NavigationDataBLoC wd_name_Container_NavigationDataBLoC =
      NavigationDataBLoC();

  TextEditingController _size_txt_Controller = TextEditingController();
  FocusNode _size_FocusNode = FocusNode();
  NavigationDataBLoC wd_size_Container_NavigationDataBLoC =
      NavigationDataBLoC();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController!,
        curve: const Interval((1 / 9) * 0, 1.0, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController?.dispose();
    }
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    String TAG = 'AddCountryDialog afterFirstLayout:';

    _setUpData(context);
  }

  _setUpData(BuildContext context) async {
    if (isStringValid(widget.farm.farm_name)) {
      _name_txt_Controller.text = widget.farm.farm_name!;
    }

    if (isStringValid(widget.farm.farm_size)) {
      _size_txt_Controller.text = widget.farm.farm_size!;
    }
  }

  @override
  Widget build(BuildContext context) {
    _animationController!.forward();
    return AlertDialog(
      elevation: 8,
      backgroundColor:
          FarmerAppTheme.sm_bg_background, //FarmerAppTheme.transparent,
      contentPadding: const EdgeInsets.all(0.0),
      titlePadding: const EdgeInsets.all(0),
      content: Container(
        decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
          color: FarmerAppTheme.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            top: 8,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _animationController!,
                      builder: (BuildContext context, Widget? child) {
                        return FadeTransition(
                          opacity: animation!,
                          child: Transform(
                            transform: Matrix4.translationValues(
                                0.0, 30 * (1.0 - animation!.value), 0.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, right: 0, top: 0, bottom: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FarmerAppTheme.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: const Radius.circular(8.0),
                                      bottomLeft: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                      topRight: const Radius.circular(8.0)),
                                ),
                                child: Form(
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, left: 16, right: 24),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4,
                                              right: 16,
                                              top: 8,
                                              bottom: 3),
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                              fontFamily: FarmerAppTheme
                                                  .font_AvenirLTStd_Medium,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FarmerAppTheme.pltf_grey,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, bottom: 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  Expanded(
                                                      child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FarmerAppTheme.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      8.0)),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            offset:
                                                                const Offset(
                                                                    0.3, 2),
                                                            blurRadius: 4.0),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              right: 4,
                                                              top: 0,
                                                              bottom: 0),
                                                      child: TextFormField(
                                                        keyboardType:
                                                            TextInputType.name,
                                                        style: TextStyle(
                                                          fontFamily: FarmerAppTheme
                                                              .font_AvenirLTStd_Medium,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          letterSpacing: 0.0,
                                                          color: FarmerAppTheme
                                                              .darkText,
                                                        ),
                                                        cursorColor: Colors.grey
                                                            .withOpacity(0.6),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: "Name",
                                                          hintStyle: TextStyle(
                                                            fontFamily:
                                                                FarmerAppTheme
                                                                    .font_AvenirLTStd_Book,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            letterSpacing: 0.0,
                                                            color:
                                                                FarmerAppTheme
                                                                    .darkText,
                                                          ),
                                                          errorStyle: TextStyle(
                                                              color:
                                                                  FarmerAppTheme
                                                                      .red,
                                                              fontSize: 12.0,
                                                              fontFamily:
                                                                  FarmerAppTheme
                                                                      .font_AvenirLTStd_Light),
                                                          prefixIcon: Icon(
                                                            Icons.edit,
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.4),
                                                            size: 15.0,
                                                          ),
                                                        ),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        onChanged:
                                                            (String val) {
                                                          _nameChanged();
                                                        },
                                                        controller:
                                                            _name_txt_Controller,
                                                        focusNode:
                                                            _name_FocusNode,
                                                        autofocus: false,
                                                        onFieldSubmitted:
                                                            (String val) {
                                                          _name_FocusNode
                                                              .unfocus();
                                                        },
                                                      ),
                                                    ),
                                                  )),
                                                ]),
                                                StreamBuilder(
                                                  stream:
                                                      wd_name_Container_NavigationDataBLoC
                                                          .stream_counter,
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              NavigationData>
                                                          snapshot) {
                                                    if (snapshot.hasError) {
                                                      return invisibleWidget();
                                                    }
                                                    switch (snapshot
                                                        .connectionState) {
                                                      case ConnectionState.none:
                                                        return invisibleWidget();
                                                      case ConnectionState
                                                          .waiting:
                                                        return invisibleWidget();
                                                      case ConnectionState
                                                          .active:
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
                                              left: 4,
                                              right: 16,
                                              top: 8,
                                              bottom: 3),
                                          child: Text(
                                            'Size',
                                            style: TextStyle(
                                              fontFamily: FarmerAppTheme
                                                  .font_AvenirLTStd_Medium,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              letterSpacing: 0.0,
                                              color: FarmerAppTheme.pltf_grey,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, bottom: 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  Expanded(
                                                      child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FarmerAppTheme.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          8.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      8.0)),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            offset:
                                                                const Offset(
                                                                    0.3, 2),
                                                            blurRadius: 4.0),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              right: 4,
                                                              top: 0,
                                                              bottom: 0),
                                                      child: TextFormField(
                                                        keyboardType:
                                                            TextInputType.name,
                                                        style: TextStyle(
                                                          fontFamily: FarmerAppTheme
                                                              .font_AvenirLTStd_Medium,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          letterSpacing: 0.0,
                                                          color: FarmerAppTheme
                                                              .darkText,
                                                        ),
                                                        cursorColor: Colors.grey
                                                            .withOpacity(0.6),
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: "Size",
                                                          hintStyle: TextStyle(
                                                            fontFamily:
                                                                FarmerAppTheme
                                                                    .font_AvenirLTStd_Book,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            letterSpacing: 0.0,
                                                            color:
                                                                FarmerAppTheme
                                                                    .darkText,
                                                          ),
                                                          errorStyle: TextStyle(
                                                              color:
                                                                  FarmerAppTheme
                                                                      .red,
                                                              fontSize: 12.0,
                                                              fontFamily:
                                                                  FarmerAppTheme
                                                                      .font_AvenirLTStd_Light),
                                                          prefixIcon: Icon(
                                                            Icons.edit,
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.4),
                                                            size: 15.0,
                                                          ),
                                                        ),
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        onChanged:
                                                            (String val) {
                                                          _sizeChanged();
                                                        },
                                                        controller:
                                                            _size_txt_Controller,
                                                        focusNode:
                                                            _size_FocusNode,
                                                        autofocus: false,
                                                        onFieldSubmitted:
                                                            (String val) {
                                                          _size_FocusNode
                                                              .unfocus();
                                                        },
                                                      ),
                                                    ),
                                                  )),
                                                ]),
                                                StreamBuilder(
                                                  stream:
                                                      wd_size_Container_NavigationDataBLoC
                                                          .stream_counter,
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              NavigationData>
                                                          snapshot) {
                                                    if (snapshot.hasError) {
                                                      return invisibleWidget();
                                                    }
                                                    switch (snapshot
                                                        .connectionState) {
                                                      case ConnectionState.none:
                                                        return invisibleWidget();
                                                      case ConnectionState
                                                          .waiting:
                                                        return invisibleWidget();
                                                      case ConnectionState
                                                          .active:
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
                                            top: 10,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: invisibleWidget(),
                                              ),
                                              Container(
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      print('cancel clicked');
                                                      _dismissSelf(null);
                                                    },
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      const Radius.circular(
                                                          43.0),
                                                    ),
                                                    splashColor: FarmerAppTheme
                                                        .pltf_pink,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FarmerAppTheme
                                                            .pltf_pink
                                                            .withOpacity(0.8),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                              color: FarmerAppTheme
                                                                  .lma_purple_2
                                                                  .withOpacity(
                                                                      0.4),
                                                              offset:
                                                                  const Offset(
                                                                      3.0, 3.0),
                                                              blurRadius: 2.0),
                                                        ],
                                                        borderRadius: const BorderRadius
                                                                .only(
                                                            topLeft: const Radius
                                                                .circular(3.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    3.0),
                                                            bottomRight:
                                                                const Radius
                                                                        .circular(
                                                                    3.0),
                                                            topRight: const Radius
                                                                .circular(3.0)),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 3,
                                                          bottom: 3,
                                                          left: 10,
                                                          right: 10,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                color:
                                                                    FarmerAppTheme
                                                                        .white,
                                                                fontFamily:
                                                                    FarmerAppTheme
                                                                        .font_AvenirLTStd_Medium,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: InkWell(
                                                        onTap: () {
                                                          print('ok clicked');
                                                          _saveData(context);
                                                        },
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              43.0),
                                                        ),
                                                        splashColor:
                                                            FarmerAppTheme
                                                                .pltf_pink,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FarmerAppTheme
                                                                .pltf_pink
                                                                .withOpacity(
                                                                    0.8),
                                                            boxShadow: <
                                                                BoxShadow>[
                                                              BoxShadow(
                                                                  color: FarmerAppTheme
                                                                      .lma_purple_2
                                                                      .withOpacity(
                                                                          0.4),
                                                                  offset:
                                                                      const Offset(
                                                                          3.0,
                                                                          3.0),
                                                                  blurRadius:
                                                                      2.0),
                                                            ],
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft:
                                                                    const Radius
                                                                            .circular(
                                                                        3.0),
                                                                bottomLeft:
                                                                    Radius
                                                                        .circular(
                                                                            3.0),
                                                                bottomRight:
                                                                    const Radius
                                                                            .circular(
                                                                        3.0),
                                                                topRight:
                                                                    const Radius
                                                                            .circular(
                                                                        3.0)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 3,
                                                              bottom: 3,
                                                              left: 20,
                                                              right: 20,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'OK',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FarmerAppTheme
                                                                        .white,
                                                                    fontFamily:
                                                                        FarmerAppTheme
                                                                            .font_AvenirLTStd_Medium,
                                                                  ),
                                                                ),
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
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _nameChanged() {
    widget.farm.farm_name = _name_txt_Controller.text;
    print("_name_txt_Controller.text${_name_txt_Controller.text}");
    _validate_Name();
  }

  _sizeChanged() {
    widget.farm.farm_size = _size_txt_Controller.text;
    _validate_Size();
  }

  //VALIDATORS
  bool _validate_Name() {
    String? name = widget.farm.farm_name;

    if (name != null && isStringValid(name)) {
      refresh_W_Data_IsValid_NavigationDataBLoC(
        true,
        wd_name_Container_NavigationDataBLoC,
        null,
      );
      return true;
    } else {
      refresh_W_Data_IsValid_NavigationDataBLoC(
        false,
        wd_name_Container_NavigationDataBLoC,
        'farm name is invalid',
      );
      return false;
    }
  }

  bool _validate_Size() {
    String? size = widget.farm.farm_size;
    if (size != null && isStringValid(widget.farm.farm_size!)) {
      refresh_W_Data_IsValid_NavigationDataBLoC(
        true,
        wd_size_Container_NavigationDataBLoC,
        null,
      );
      return true;
    } else {
      refresh_W_Data_IsValid_NavigationDataBLoC(
        false,
        wd_size_Container_NavigationDataBLoC,
        'farm size is invalid',
      );
      return false;
    }
  }

  Future<bool> isDataValid() async {
    bool isDataValid = true;
    bool _is_validate_Name = _validate_Name();
    bool _IS_validate_Size = _validate_Size();

    isDataValid = _is_validate_Name && _IS_validate_Size;
    return isDataValid;
  }

  //END OF VALIDATORS

  _saveData(BuildContext context) async {
    _name_FocusNode.unfocus();
    String TAG = 'saveData';
    if (await isDataValid()) {
      //SAVE Farm For User
      FarmListVM _farmListVM = FarmListVM();
      widget.farm.issettobeupdated=true;
      if (widget.farm.id != null) {
        //update
        await _farmListVM.updateFarmlocal(widget.farm, context);
      } else {
        await _farmListVM.insertFarmlocal(widget.farm, context);
      }
      _dismissSelf(widget.farm);
    }
  }

  _dismissSelf(FarmRespJModel? farmRespJModel) {
    Navigator.pop(context, farmRespJModel);
  }
}
