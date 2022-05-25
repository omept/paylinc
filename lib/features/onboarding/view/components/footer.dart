import 'package:flutter/material.dart';
import 'package:paylinc/features/onboarding/utils/screen_helper.dart';
import 'package:paylinc/shared_components/shared_components.dart';

final List<FooterItem> footerItems = [
  FooterItem(
    iconPath: "assets/images/raster/welcome/mappin.png",
    title: "ADDRESS",
    text1: "9 Adebayo Adekoya Street",
    text2: "Gbagada, Lagos Nigeria",
  ),
  FooterItem(
    iconPath: "assets/images/raster/welcome/phone.png",
    title: "PHONE",
    text1: "+234-816-322-9099",
    text2: "+234-817-931-9079",
  ),
  FooterItem(
    iconPath: "assets/images/raster/welcome/email.png",
    title: "EMAIL",
    text1: "george.onwuasoanya@omept.com",
    text2: "support@omept.com",
  ),
  FooterItem(
    iconPath: "assets/images/raster/welcome/whatsapp.png",
    title: "WHATSAPP",
    text1: "+234-816-322-9099",
    text2: "+234-817-931-9079",
  )
];

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: footerItems
                      .map(
                        (footerItem) => Container(
                          height: 120.0,
                          width: ScreenHelper.isMobile(context)
                              ? constraints.maxWidth / 2.0 - 20.0
                              : constraints.maxWidth / 4.0 - 20.0,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      footerItem.iconPath,
                                      width: 25.0,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      footerItem.title,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                        color: themeContext
                                            .colorScheme.onBackground,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${footerItem.text1}\n",
                                        style: TextStyle(
                                          color: themeContext
                                              .textTheme.caption?.color,
                                          height: 1.8,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${footerItem.text2}\n",
                                        style: TextStyle(
                                          color: themeContext
                                              .textTheme.caption?.color,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Flex(
                direction: ScreenHelper.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                mainAxisAlignment: ScreenHelper.isMobile(context)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Copyright (c) Omept Technologies Nigeria Limited. All rights Reserved",
                      style: TextStyle(
                        color: themeContext.textTheme.caption?.color,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: themeContext.textTheme.caption?.color,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "|",
                          style: TextStyle(
                            color: themeContext.textTheme.caption?.color,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            "Terms & Conditions",
                            style: TextStyle(
                              color: themeContext.textTheme.caption?.color,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
