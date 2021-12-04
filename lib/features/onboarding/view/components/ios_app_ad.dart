import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paylinc/constants/app_constants.dart';

class IosAppAd extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/raster/welcome/ios.png",
              // Set width for image on smaller screen
              // width: 350.0,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "IOS APP",
                  style: GoogleFonts.oswald(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "UNIVERSAL\nSMART HOME APP",
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                    fontSize: 35.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "This is a random text about the project, I should have used the regular lorem ipsum text, but I am too lazy to search for that. This should be long enough",
                  style: TextStyle(
                    color: kCaptionColor,
                    height: 1.5,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  children: [
                    // MouseRegion(
                    //   cursor: SystemMouseCursors.click,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: kPrimaryColor,
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     height: 48.0,
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: 28.0,
                    //     ),
                    //     child: TextButton(
                    //       onPressed: () {},
                    //       child: Center(
                    //         child: Text(
                    //           "EXPLORE MORE",
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 13.0,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 10.0,
                    // ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: kPrimaryColor,
                          ),
                        ),
                        height: 48.0,
                        padding: EdgeInsets.symmetric(horizontal: 28.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              "NEXT APP",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
