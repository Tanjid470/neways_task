import 'package:flutter/material.dart';


class SizeConfig {

  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? statusBarHeight;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  /// This class measures the screen height & width.
  /// Remember: Always call the init method at the start of your application or in main
  void init(BuildContext? context) {
    _mediaQueryData = MediaQuery.of(context!);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = (screenHeight! / 100);

    _safeAreaHorizontal = (_mediaQueryData?.padding.left)! + (_mediaQueryData?.padding.right)!;
    _safeAreaVertical = (_mediaQueryData?.padding.top)!  + kToolbarHeight; //+ (_mediaQueryData?.padding.bottom)!
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;

    statusBarHeight = _mediaQueryData!.padding.top;
  }
}