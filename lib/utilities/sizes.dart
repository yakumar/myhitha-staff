import 'package:flutter/material.dart';

Size displaySize(BuildContext context) {
  // debugPrint('Size = ' + MediaQuery.of(context).size.toString());

  return MediaQuery.of(context).size;
}

double displayWidth(BuildContext context) {
  // debugPrint('Height = ' + displaySize(context).height.toString());

  return displaySize(context).width;
}

double displayHeight(BuildContext context) {
  // debugPrint('Width = ' + displaySize(context).width.toString());

  return displaySize(context).height;
}
