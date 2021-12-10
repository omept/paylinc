import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/onboarding/utils/screen_helper.dart';
import 'package:paylinc/shared_components/models/design_process.dart';
import 'package:responsive_framework/responsive_framework.dart';

final List<DesignProcess> designProcesses = [
  DesignProcess(
    title: "DESIGN",
    imagePath: "assets/images/raster/welcome/design.png",
    subtitle:
        "A full stack allround designer thay may or may not include a guide for specific creative",
  ),
  DesignProcess(
    title: "DEVELOP",
    imagePath: "assets/images/raster/welcome/develop.png",
    subtitle:
        "A full stack allround developer thay may or may not include a guide for specific creative",
  ),
  DesignProcess(
    title: "WRITE",
    imagePath: "assets/images/raster/welcome/write.png",
    subtitle:
        "A full stack allround writer thay may or may not include a guide for specific creative",
  ),
  DesignProcess(
    title: "PROMOTE",
    imagePath: "assets/images/raster/welcome/promote.png",
    subtitle:
        "A full stack allround promoter thay may or may not include a guide for specific creative",
  ),
];

class CvSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "BETTER DESIGN,\nBETTER EXPERIENCES",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  height: 1.8,
                  fontSize: 18.0,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    "DOWNLOAD CV",
                    style: TextStyle(
                      color: themeContext.primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: LayoutBuilder(
              builder: (_context, constraints) {
                return ResponsiveGridView.builder(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  alignment: Alignment.topCenter,
                  gridDelegate: ResponsiveGridDelegate(
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    maxCrossAxisExtent: ScreenHelper.isTablet(context) ||
                            ScreenHelper.isMobile(context)
                        ? constraints.maxWidth / 2.0
                        : 250.0,
                    // Hack to adjust child height
                    childAspectRatio: ScreenHelper.isDesktop(context)
                        ? 1
                        : MediaQuery.of(context).size.aspectRatio * 1.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                designProcesses[index].imagePath,
                                width: 40.0,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                designProcesses[index].title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: themeContext.colorScheme.onBackground,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            designProcesses[index].subtitle,
                            style: TextStyle(
                              color: themeContext.textTheme.caption?.color,
                              height: 1.5,
                              fontSize: 14.0,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: designProcesses.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
