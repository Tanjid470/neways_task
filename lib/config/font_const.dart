
import 'package:flutter/cupertino.dart';
import 'package:neways_task/config/responsive_scale.dart';


class FontConstants{
  static double appTextLS = -0.4;
  static double appTitleLS = -0.8;
  static double drawerUserNameLS = 0.2;

}

class TextSize {
  static font10(BuildContext context) => ResponsiveScale.of(context).fontSize(1.15);
  static font12(BuildContext context) => ResponsiveScale.of(context).fontSize(1.37);
  static font14(BuildContext context) => ResponsiveScale.of(context).fontSize(1.6);
  static font15(BuildContext context) => ResponsiveScale.of(context).fontSize(1.7);
  static font16(BuildContext context) => ResponsiveScale.of(context).fontSize(1.82);
  static font18(BuildContext context) => ResponsiveScale.of(context).fontSize(2.06);
  static font20(BuildContext context) => ResponsiveScale.of(context).fontSize(2.3);
  static font22(BuildContext context) => ResponsiveScale.of(context).fontSize(2.5);
  static font24(BuildContext context) => ResponsiveScale.of(context).fontSize(2.7);
  static font26(BuildContext context) => ResponsiveScale.of(context).fontSize(3);
  static font28(BuildContext context) => ResponsiveScale.of(context).fontSize(3.2);
  static font30(BuildContext context) => ResponsiveScale.of(context).fontSize(4.3);
  static font36(BuildContext context) => ResponsiveScale.of(context).fontSize(4.1);
  static font48(BuildContext context) => ResponsiveScale.of(context).fontSize(5.5);
  static font54(BuildContext context) => ResponsiveScale.of(context).fontSize(6.17);

}

SizedBox verticalGap(BuildContext context,double ratio) =>
    SizedBox(height: ResponsiveScale.of(context).hp(ratio));
SizedBox horizontalGap(BuildContext context,double ratio) =>
    SizedBox(width: ResponsiveScale.of(context).wp(ratio));
