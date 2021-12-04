import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/models/carousel_item_model.dart';

List<CarouselItemModel> carouselItems = [
  CarouselItemModel(
    text: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Reliable",
            style: GoogleFonts.oswald(
              color: kPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 18.0,
          ),
          Text(
            "PAY ON \nDELIVERY",
            style: GoogleFonts.oswald(
              color: Colors.white,
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
              color: kCaptionColor,
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
                    color: kCaptionColor,
                    fontSize: 15.0,
                    height: 1.5,
                  ),
                ),
                // GestureDetector(
                //   onTap: () {},
                //   child: MouseRegion(
                //     cursor: SystemMouseCursors.click,
                //     child: Text(
                //       " Got a project? Let's talk.",
                //       style: TextStyle(
                //         height: 1.5,
                //         color: Colors.white,
                //         fontSize: 15.0,
                //       ),
                //     ),
                //   ),
                // )
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
                color: kPrimaryColor,
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
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
    image: Container(
      child: Image.asset(
        "assets/images/raster/welcome/person.png",
        fit: BoxFit.contain,
      ),
    ),
  ),
  CarouselItemModel(
    text: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Quick Response",
            style: GoogleFonts.oswald(
              color: kPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 18.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "lorem ipsum , based in Barcelona",
            style: TextStyle(
              color: kCaptionColor,
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
                  "lorem ipsum full custom website?",
                  style: TextStyle(
                    color: kCaptionColor,
                    fontSize: 15.0,
                    height: 1.5,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      " lorem ipsum  Let's talk.",
                      style: TextStyle(
                        height: 1.5,
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                )
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
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 48.0,
              padding: EdgeInsets.symmetric(
                horizontal: 28.0,
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "GET STARTED",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
    image: Container(
      child: Image.asset(
        "assets/images/raster/welcome/person.png",
        fit: BoxFit.contain,
      ),
    ),
  ),
];

// );List.generate(
// List.generate(
//   5,
//   (index) => CarouselItemModel(
//     text: Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "PRODUCT DESIGNER",
//             style: GoogleFonts.oswald(
//               color: kPrimaryColor,
//               fontWeight: FontWeight.w900,
//               fontSize: 16.0,
//             ),
//           ),
//           SizedBox(
//             height: 18.0,
//           ),
//           Text(
//             "MICHELE\nHARRINGTON",
//             style: GoogleFonts.oswald(
//               color: Colors.white,
//               fontSize: 40.0,
//               fontWeight: FontWeight.w900,
//               height: 1.3,
//             ),
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           Text(
//             "Full-stack developer, based in Barcelona",
//             style: TextStyle(
//               color: kCaptionColor,
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
//                   "Need a full custom website?",
//                   style: TextStyle(
//                     color: kCaptionColor,
//                     fontSize: 15.0,
//                     height: 1.5,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: MouseRegion(
//                     cursor: SystemMouseCursors.click,
//                     child: Text(
//                       " Got a project? Let's talk.",
//                       style: TextStyle(
//                         height: 1.5,
//                         color: Colors.white,
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
//                 color: kPrimaryColor,
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
//                     color: Colors.white,
//                     fontSize: 13.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//     image: Container(
//       child: Image.asset(
//         "assets/images/raster/welcome/person.png",
//         fit: BoxFit.contain,
//       ),
//     ),
//   ),
// );
