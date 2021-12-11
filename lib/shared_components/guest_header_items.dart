import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/onboarding/view/onboarding_page.dart';
import 'package:paylinc/shared_components/models/header_item.dart';

final List<HeaderItem> guestHeaderItems = [
  HeaderItem(
    title: "Login",
    onTap: () => Get.offNamed(Routes.login),
    isButton: true,
  ),
  HeaderItem(
      title: "Sign up",
      onTap: () {
        Get.offNamed(Routes.sign_up);
      }),
  HeaderItem(
    title: "Learn More",
    onTap: () {},
  ),
];

Widget guestHeaderRow() {
  return Builder(builder: (context) {
    var themeContext = Theme.of(context);
    return Row(
      textDirection: TextDirection.rtl,
      children: guestHeaderItems
          .map(
            (item) => item.isButton
                ? MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kDangerColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: TextButton(
                        onPressed: item.onTap,
                        child: Text(
                          item.title,
                          style: menuItemTextStyle(
                              color: themeContext.colorScheme.onBackground),
                        ),
                      ),
                    ),
                  )
                : MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      margin: EdgeInsets.only(right: 30.0),
                      child: GestureDetector(
                        onTap: item.onTap,
                        child: Text(
                          item.title,
                          style: menuItemButtonStyle(
                              color: themeContext.colorScheme.onBackground),
                        ),
                      ),
                    ),
                  ),
          )
          .toList(),
    );
  });
}
