import 'package:farmer_app/model/model/custom/NavigationData.dart';
import 'package:farmer_app/utils/themes/farmer_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget wd_Text_Widget_Form_Validator_Text(
  AsyncSnapshot<NavigationData> snapshot,
) {
  NavigationData? navigationdata = snapshot.data;
  if (navigationdata != null) {
    if (navigationdata.isValid != null) {
      if (navigationdata.isValid!) {
        return invisibleWidget();
      } else {
        return Padding(
          padding: EdgeInsets.only(top: 2),
          child: Text(
            navigationdata.message!,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: FarmerAppTheme.red,
                fontSize: 12.0,
                fontFamily: FarmerAppTheme.font_AvenirLTStd_Light),
          ),
        );
      }
    } else {
      return invisibleWidget();
    }
  } else {
    return invisibleWidget();
  }
}

Widget invisibleWidget() {
  return Visibility(
    visible: false,
    child: SizedBox(
      height: 0,
      width: 0,
    ),
  );
}

void showSnackbarWBgCol(
  String message,
  BuildContext context,
  Color bgcolor,
) {
  if (context != null) {
    SnackBar snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: TextStyle(
          fontFamily: FarmerAppTheme.font_AvenirLTStd_Medium,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: 0.0,
          color: FarmerAppTheme.white,
        ),
      ),
      action: SnackBarAction(
          label: 'OK', textColor: FarmerAppTheme.white, onPressed: () {}),
      backgroundColor: bgcolor,
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
