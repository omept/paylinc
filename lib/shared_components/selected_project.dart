import 'package:flutter/material.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/shared_components/project_card.dart';

ProjectCardData getSelectedProject() {
  return ProjectCardData(
    percent: .3,
    projectImage: const AssetImage(ImageRasterPath.logo1),
    projectName: "Paylinc",
    releaseTime: DateTime.now(),
  );
}
