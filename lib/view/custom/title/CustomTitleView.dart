

import 'package:flutter/material.dart';

class CustomTitleView extends StatelessWidget {
  String? titleTxt;
  String? subTxt;
  AnimationController? animationController;
  Animation<double>? animation;
  TextStyle? titleTextStyle;
  TextStyle? subtitleTextStyle;

  CustomTitleView({
    Key? key,
    this.titleTxt: "",
    this.subTxt: "",
    this.animationController,
    this.animation,
    this.titleTextStyle,
    this.subtitleTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        titleTxt!,
                        textAlign: TextAlign.left,
                        style: titleTextStyle,
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              subTxt!,
                              textAlign: TextAlign.left,
                              style: subtitleTextStyle,
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
