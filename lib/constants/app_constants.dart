library app_constants;

import 'package:flutter/cupertino.dart';
import 'package:user_repository/user_repository.dart';

part 'api_path.dart';
part 'assets_path.dart';
part 'enums.dart';

const kBorderRadius = 20.0;
const kSpacing = 20.0;
final kCountry = Country(countryName: "Nigeria", countryId: 1);
const Color kNotifColor = Color.fromRGBO(74, 177, 120, 1);
//const Color kGrayTextColor = Color.fromRGBO(170, 170, 170, 1);
const Color kLightGrayTextColor = Color.fromRGBO(210, 210, 210, 1);
const Color kWhiteTextColor = Color.fromRGBO(255, 255, 255, 1);

const Color kPrimaryColor = Color.fromRGBO(21, 181, 114, 1);
const Color kBackgroundColor = Color.fromRGBO(7, 17, 26, 1);
const Color kDangerColor = Color.fromRGBO(249, 77, 30, 1);
const Color kCaptionColor = Color.fromRGBO(166, 177, 187, 1);
const double kDesktopMaxWidth = 1000.0;
const double kTabletMaxWidth = 760.0;
double getMobileMaxWidth(BuildContext context) =>
    MediaQuery.of(context).size.width * .8;
