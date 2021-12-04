import 'package:flutter/material.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/onboarding/utils/screen_helper.dart';

final List<String> sponsorsLogo = [
  "assets/images/raster/welcome/brand1.png",
  "assets/images/raster/welcome/brand2.png",
  "assets/images/raster/welcome/brand3.png",
  "assets/images/raster/welcome/brand4.png",
  "assets/images/raster/welcome/brand5.png",
];

class Sponsors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50.0),
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth),
        tablet: _buildUi(kTabletMaxWidth),
        mobile: _buildUi(getMobileMaxWidth(context)),
      ),
    );
  }
}

Widget _buildUi(double width) {
  return Center(
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Wrap(
          runSpacing: 50.0,
          spacing: 50.0,
          children: sponsorsLogo
              .map(
                (logo) => Container(
                  height: 20.0,
                  child: Image.asset(logo),
                  constraints: BoxConstraints(
                    // max of 3 per row when on mobile and 5 per row on bigger screens
                    maxWidth: ScreenHelper.isMobile(context)
                        ? constraints.maxWidth / 3.0 - 50.0
                        : constraints.maxWidth / 5.0 - 50.0,
                  ),
                ),
              )
              .toList(),
        );
      },
    ),
  );
}
