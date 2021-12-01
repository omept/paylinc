import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:paylinc/features/onboarding/utils/screen_helper.dart';
import 'package:paylinc/features/onboarding/view/components/carousel_items.dart';

class Carousel extends StatelessWidget {
  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    double carouselContainerHeight = MediaQuery.of(context).size.height *
        (ScreenHelper.isMobile(context) ? .7 : .85);
    return Container(
      height: carouselContainerHeight,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                // autoPlay: true,
                viewportFraction: 1,
                scrollPhysics: NeverScrollableScrollPhysics(),
                height: carouselContainerHeight,
              ),
              items: List.generate(
                carouselItems.length,
                (index) => Builder(
                  builder: (BuildContext context) {
                    return Container(
                      constraints: BoxConstraints(
                        minHeight: carouselContainerHeight,
                      ),
                      child: ScreenHelper(
                        // Responsive views
                        desktop: _buildDesktop(
                          context,
                          carouselItems[index].text,
                          carouselItems[index].image,
                        ),
                        tablet: _buildTablet(
                          context,
                          carouselItems[index].text,
                          carouselItems[index].image,
                        ),
                        mobile: _buildMobile(
                          context,
                          carouselItems[index].text,
                          carouselItems[index].image,
                        ),
                      ),
                    );
                  },
                ),
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}

// Big screens
Widget _buildDesktop(BuildContext context, Widget text, Widget image) {
  return Center(
    child: Row(
      children: [
        Expanded(
          child: text,
        ),
        Expanded(
          child: image,
        )
      ],
    ),
  );
}

// Mid screens
Widget _buildTablet(BuildContext context, Widget text, Widget image) {
  return Center(
    child: Row(
      children: [
        Expanded(
          child: text,
        ),
        Expanded(
          child: image,
        )
      ],
    ),
  );
}

// SMall Screens

Widget _buildMobile(BuildContext context, Widget text, Widget image) {
  return Container(
    // constraints: BoxConstraints(
    //   maxWidth: getMobileMaxWidth(context),
    // ),
    // width: double.infinity,
    child: text,
  );
}
