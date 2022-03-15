import 'package:flutter/material.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/validate_otp/view/validate_otp_form.dart';
import 'package:paylinc/shared_components/shared_components.dart';

class ValidateOtpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: _validateOtpMobileScreenWidget,
          tabletBuilder: _validateOtpDesktopScreenWidget,
          desktopBuilder: _validateOtpDesktopScreenWidget,
        ),
      ),
      // }
    );
  }

  Widget _validateOtpDesktopScreenWidget(context, constraints) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Flexible(
          child: Container(
            height: size.height,
            child: Center(
              child: Container(
                width: 200,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(kSpacing),
                  child: ProjectCard(
                    data: projectCardData(),
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: kSpacing * 2),
                  SizedBox(
                      width: size.width / 1.5,
                      child:
                          _validateOtpMobileScreenWidget(context, constraints))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ProjectCardData getSelectedProject() {
    return ProjectCardData(
      percent: .3,
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Paylinc",
      releaseTime: DateTime.now(),
    );
  }

  Widget _validateOtpMobileScreenWidget(context, constraints) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(kSpacing),
      child: Container(
        height: size.height - 40,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: kSpacing * 10),
              Text('Validate Otp',
                  style: TextStyle(
                    fontSize: 22.0,
                  )),
              const SizedBox(height: kSpacing * 2),
              ValidateOtpForm(),
              const SizedBox(height: kSpacing),
            ]),
      ),
    );
  }
}
