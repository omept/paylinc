import 'package:flutter/material.dart';

class IosAppAd extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    var themeContext = Theme.of(context);
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
                  "iOS & Android App",
                  style: TextStyle(
                    color: themeContext.primaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Paylinc Escrow Fintech Application by Omept",
                  style: TextStyle(
                    color: themeContext.colorScheme.onBackground,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                    fontSize: 35.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "An escrow is the use of a third party, which holds an asset or funds before they are transferred from one party to another.  Paylinc is an escrow that enables you pay for goods and services in a secure and easy way.",
                  style: TextStyle(
                    color: themeContext.textTheme.caption?.color,
                    height: 1.5,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                // Row(
                //   children: [
                //     MouseRegion(
                //       cursor: SystemMouseCursors.click,
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(8.0),
                //           border: Border.all(
                //             color: themeContext.primaryColor,
                //           ),
                //         ),
                //         height: 48.0,
                //         padding: EdgeInsets.symmetric(horizontal: 28.0),
                //         child: TextButton(
                //           onPressed: () {},
                //           child: Center(
                //             child: Text(
                //               "NEXT APP",
                //               style: TextStyle(
                //                 color: themeContext.primaryColor,
                //                 fontSize: 13.0,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
