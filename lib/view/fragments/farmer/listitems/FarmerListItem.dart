import 'dart:async';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmerRespJModel.dart';
import 'package:farmer_app/utils/functions/validators.dart';
import 'package:farmer_app/utils/statics/farmer_app_static_params.dart';
import 'package:farmer_app/utils/themes/farmer_app_theme.dart';
import 'package:farmer_app/view/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

class FarmerListItem extends StatefulWidget {
  AnimationController? animationController;
  FarmerListItemCallback? farmerListItemCallback;
  FarmerListItemCallback? farmerListItemDeleteCallback;
  FarmerRespJModel farmerRespJModel;
  int? index;

  FarmerListItem({
    Key? key,
    this.animationController,
    this.farmerListItemCallback,
    required this.farmerRespJModel,
    this.index,
    this.farmerListItemDeleteCallback,
  }) : super(key: key);

  @override
  _FiberProjectListItemState createState() => _FiberProjectListItemState();
}

class _FiberProjectListItemState extends State<FarmerListItem>
    with TickerProviderStateMixin, AfterLayoutMixin<FarmerListItem> {
  Animation<double>? _animation;
  bool isSelected = false;

  @override
  void initState() {
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval(
            (1 / FarmerAppStaticParams.mainui_lv_itemscount) * 3, 1.0,
            curve: Curves.fastOutSlowIn)));
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void dispose() {
    String TAG = 'FarmerListItem_dispose';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.farmerRespJModel.lv_index = widget.index!;
    return Container(
      child: AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: _animation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30.0 * (1.0 - _animation!.value), 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          //right: 20,
                        ),
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ((widget.index == 0 ? 3 : 10))),
                              child: InkWell(
                                onTap: () {
                                  widget.farmerListItemCallback!(
                                    widget.farmerRespJModel,
                                    widget.index,
                                  );
                                },
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    color: FarmerAppTheme.transparent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0)),
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 0, 4, 3),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    //height: 100,
                                    decoration: BoxDecoration(
                                      color: FarmerAppTheme.white,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              //height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                        ((widget.farmerRespJModel
                                                                        .first_name !=
                                                                    null
                                                                ? widget
                                                                    .farmerRespJModel
                                                                    .first_name!
                                                                : '')) +
                                                            ' ' +
                                                            ((widget.farmerRespJModel
                                                                        .last_name !=
                                                                    null
                                                                ? widget
                                                                    .farmerRespJModel
                                                                    .last_name!
                                                                : '')),
                                                        style: const TextStyle(
                                                          fontFamily: FarmerAppTheme
                                                              .font_AvenirLTStd_Medium,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 15,
                                                          letterSpacing: -0.2,
                                                          color: FarmerAppTheme
                                                              .lma_purple_2,
                                                        )),
                                                  ),
                                                  ((isStringValid(widget
                                                          .farmerRespJModel
                                                          .gender)
                                                      ? Text(
                                                          'Gender : ' +
                                                              ((widget.farmerRespJModel
                                                                      .gender ??
                                                                  '')),
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                FarmerAppTheme
                                                                    .font_AvenirLTStd_Book,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            letterSpacing: -0.2,
                                                            color: FarmerAppTheme
                                                                .lma_grey_op_05,
                                                          ),
                                                        )
                                                      : invisibleWidget())),
                                                  ((isStringValid(widget
                                                          .farmerRespJModel
                                                          .member_number)
                                                      ? Text(
                                                          'Member No : ' +
                                                              ((widget.farmerRespJModel
                                                                      .member_number ??
                                                                  '')),
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                FarmerAppTheme
                                                                    .font_AvenirLTStd_Book,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            letterSpacing: -0.2,
                                                            color: FarmerAppTheme
                                                                .lma_grey_op_05,
                                                          ),
                                                        )
                                                      : invisibleWidget())),
                                                ],
                                              ),
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
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          right: 20,
                          top: ((widget.index == 0 ? 3 : 24)),
                          bottom: 0,
                          left: 10,
                        ),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: FarmerAppTheme.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: FarmerAppTheme.lma_purple
                                      .withOpacity(0.4),
                                  offset: Offset(8.0, 8.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                print('delete CLICKED');
                                widget.farmerListItemDeleteCallback!(
                                  widget.farmerRespJModel,
                                  widget.index,
                                );
                              },
                              borderRadius: const BorderRadius.all(
                                Radius.circular(43.0),
                              ),
                              splashColor: FarmerAppTheme.grey,
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                    child: Icon(
                                  Icons.delete,
                                  size: 22,
                                  color: FarmerAppTheme.lma_purple_2,
                                )),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

typedef FarmerListItemCallback = void Function(
  FarmerRespJModel farmerRespJModel,
  int? index,
);
