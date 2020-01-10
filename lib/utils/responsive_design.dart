import 'package:flutter/cupertino.dart';
// Responsive design is a helper class that provide functions that
// help adjusting the dimension according to the device screen size
// to provide a responsive design and a better user experience

class ResponsiveDesign{

  static setWidth({double width,BuildContext context})
    => double.parse(((width/360.0) * MediaQuery.of(context).size.width).toStringAsFixed(2));

  static setHeight({double height,BuildContext context})
    =>double.parse(((height/640.0) * MediaQuery.of(context).size.height).toStringAsFixed(2));

  static setFontSize({double fontSize,BuildContext context})
    => double.parse(((fontSize/360.0) * MediaQuery.of(context).size.width).toStringAsFixed(2));

  static justify({double dimension,BuildContext context})
   => double.parse((((MediaQuery.of(context).size.width/MediaQuery.of(context).size.height)
       * dimension) / 0.5625).toStringAsFixed(2));

  static screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

}
