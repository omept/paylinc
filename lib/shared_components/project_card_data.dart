part of shared_components;

ProjectCardData projectCardData() {
  return ProjectCardData(
    percent: .3,
    projectImage: const AssetImage(ImageRasterPath.logo1),
    projectName: "Paylinc",
    releaseTime: DateTime.now(),
  );
}
