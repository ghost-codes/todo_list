import 'package:flutter/material.dart';
import 'package:todo_list/core/util/appColors.dart';

class LTextThemes {
  static const TextStyle smallBodywhite = TextStyle(
    color: LColors.white,
    fontSize: 14,
    fontFamily: "OpenSans",
  );
  static const TextStyle smallBodyBlack = TextStyle(
    color: LColors.black,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    fontFamily: "OpenSans",
  );
  static const TextStyle smallBodyPrim = TextStyle(
    color: LColors.primaryColor,
    fontSize: 14,
    fontFamily: "OpenSans",
  );
  static const TextStyle tinyFadedAnotePrim = TextStyle(
    color: LColors.offWhite,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    fontFamily: "OpenSans",
  );
  static const TextStyle bigTitleWhite = TextStyle(
    color: LColors.white, fontSize: 20, fontWeight: FontWeight.w600,
    // fontFamily: ,
  );
}
