import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/models/education.dart';

final List<Education> educationList = [
  Education(
    description:
        "This is a sample education and details about it is stated below. This is a sample education and details about it is stated below",
    linkName: "www.flutterpanda.com",
    period: "2019 - PRESENT",
  ),
  Education(
    description:
        "This is a sample education and details about it is stated below.This is a sample education and details about it is stated below",
    linkName: "www.flutterpanda.com",
    period: "2018 - 2019",
  ),
  Education(
    description:
        "This is a sample education and details about it is stated below. This is a sample education and details about it is stated below",
    linkName: "www.flutterpanda.com",
    period: "2017 - 2018",
  ),
  Education(
    description:
        "This is a sample education and details about it is stated below. This is a sample education and details about it is stated below",
    linkName: "www.flutterpanda.com",
    period: "2016 - 2017",
  ),
];

class EducationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeContext = Theme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "EDUCATION",
            style: TextStyle(
              color: themeContext.colorScheme.onBackground,
              fontWeight: FontWeight.w900,
              fontSize: 30.0,
              height: 1.3,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Wrap(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 400.0),
                child: Text(
                  "A full stack all round developer that does all the job he needs to do at all times. Actually this is a false statement",
                  style: TextStyle(
                    color: themeContext.colorScheme.onBackground,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: educationList
                      .map(
                        (education) => Container(
                          width: constraints.maxWidth / 2.0 - 20.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                education.period,
                                style: TextStyle(
                                  color: themeContext.colorScheme.onBackground,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                education.description,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: themeContext.textTheme.caption?.color,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    education.linkName,
                                    style: TextStyle(
                                      color:
                                          themeContext.colorScheme.onBackground,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
