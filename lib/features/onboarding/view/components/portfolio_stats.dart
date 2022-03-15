import 'package:flutter/material.dart';
import 'package:paylinc/features/onboarding/utils/screen_helper.dart';
import 'package:paylinc/shared_components/shared_components.dart';

final List<Stat> stats = [
  Stat(count: "43", text: "Clients"),
  Stat(count: "68+", text: "Projects"),
  Stat(count: "17", text: "Awards"),
  Stat(count: "10", text: "Years\nExperience"),
];

class PortfolioStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      child: Container(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraint) {
            return Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: stats.map((stat) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  // Just use the helper here really
                  width: ScreenHelper.isMobile(context)
                      ? constraint.maxWidth / 2.0 - 20
                      : (constraint.maxWidth / 4.0 - 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stat.count,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32.0,
                          color: themeContext.colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        stat.text,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: themeContext.textTheme.caption?.color,
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
