part of shared_components;

class ResponsiveBuilder extends StatelessWidget {
  ResponsiveBuilder({
    required this.mobileBuilder,
    required this.tabletBuilder,
    required this.desktopBuilder,
    Key? key,
  }) : super(key: key);

  final ThemeData themeData = Theme.of(Get.context!);

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  ) mobileBuilder;

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  ) tabletBuilder;

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  ) desktopBuilder;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1250 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1250;

  Future<bool> _onWillPop() async {
    if (!Platform.isAndroid) {
      return false;
    }
    return (await showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(),
                child: Text('No',
                    style:
                        TextStyle(color: themeData.colorScheme.onBackground)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes',
                    style:
                        TextStyle(color: themeData.colorScheme.onBackground)),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1250) {
            return desktopBuilder(context, constraints);
          } else if (constraints.maxWidth >= 650) {
            return tabletBuilder(context, constraints);
          } else {
            return mobileBuilder(context, constraints);
          }
        },
      ),
    );
  }
}
