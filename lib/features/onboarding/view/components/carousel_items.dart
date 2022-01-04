import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/shared_components/models/carousel_item_model.dart';

List<CarouselItemModel> carouselItems = [
  CarouselItemModel(
    text: Container(
      child: Builder(builder: (context) {
        var themeContext = Theme.of(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Reliable",
              style: TextStyle(
                color: themeContext.primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Text(
              "PAY ON \nDELIVERY",
              style: TextStyle(
                color: themeContext.colorScheme.onBackground,
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
                height: 1.3,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "that is transparent and simple",
              style: TextStyle(
                color: themeContext.textTheme.caption?.color,
                fontSize: 15.0,
                height: 1.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Wrap(
                children: [
                  Text(
                    "What are you waiting for?",
                    style: TextStyle(
                      color: themeContext.textTheme.caption?.color,
                      fontSize: 15.0,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                decoration: BoxDecoration(
                  color: themeContext.primaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 48.0,
                padding: EdgeInsets.symmetric(
                  horizontal: 28.0,
                ),
                child: TextButton(
                  onPressed: () {
                    Get.offNamed(Routes.sign_up);
                  },
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(
                      color: themeContext.colorScheme.onBackground,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }),
    ),
    image: Container(
      child: Image.asset(
        "assets/images/raster/welcome/person.png",
        fit: BoxFit.contain,
      ),
    ),
  ),
  // CarouselItemModel(
  //   text: Container(
  //     child: Builder(builder: (context) {
  //       var themeContext = Theme.of(context);
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             "Quick Response",
  //             style: TextStyle(
  //               color: themeContext.primaryColor,
  //               fontWeight: FontWeight.w900,
  //               fontSize: 16.0,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 18.0,
  //           ),
  //           SizedBox(
  //             height: 10.0,
  //           ),
  //           Text(
  //             "you can trust",
  //             style: TextStyle(
  //               color: themeContext.textTheme.caption?.color,
  //               fontSize: 15.0,
  //               height: 1.0,
  //             ),
  //           ),
  //           SizedBox(
  //             height: 10.0,
  //           ),
  //           Container(
  //             child: Wrap(
  //               children: [
  //                 Text(
  //                   "lorem ipsum full custom website?",
  //                   style: TextStyle(
  //                     color: themeContext.textTheme.caption?.color,
  //                     fontSize: 15.0,
  //                     height: 1.5,
  //                   ),
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {},
  //                   child: MouseRegion(
  //                     cursor: SystemMouseCursors.click,
  //                     child: Text(
  //                       " lorem ipsum  Let's talk.",
  //                       style: TextStyle(
  //                         height: 1.5,
  //                         color: themeContext.colorScheme.onBackground,
  //                         fontSize: 15.0,
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           SizedBox(
  //             height: 25.0,
  //           ),
  //           MouseRegion(
  //             cursor: SystemMouseCursors.click,
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: themeContext.primaryColor,
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               height: 48.0,
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: 28.0,
  //               ),
  //               child: TextButton(
  //                 onPressed: () {},
  //                 child: Text(
  //                   "GET STARTED",
  //                   style: TextStyle(
  //                     color: themeContext.colorScheme.onBackground,
  //                     fontSize: 13.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       );
  //     }),
  //   ),
  //   image: Container(
  //     child: Image.asset(
  //       "assets/images/raster/welcome/person.png",
  //       fit: BoxFit.contain,
  //     ),
  //   ),
  // ),
];
