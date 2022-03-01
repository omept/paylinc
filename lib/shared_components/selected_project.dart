part of shared_components;

ProjectCardData getSelectedProject() {
  return ProjectCardData(
    percent: .3,
    projectImage: const AssetImage(ImageRasterPath.logo1),
    projectName: "Paylinc",
    releaseTime: DateTime.now(),
  );
}
