import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/authentication/authentication.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/project_card_data.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';

class ForgotPasswordPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ForgotPasswordPage(), settings: routeSettings);
  }

  static final RouteSettings routeSettings =
      RouteSettings(name: "/forgot-password");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: _forgotPasswordMobileScreenWidget,
          tabletBuilder: _forgotPasswordDesktopScreenWidget,
          desktopBuilder: _forgotPasswordDesktopScreenWidget,
        ),
      ),
      // }
    );
  }

  Widget _forgotPasswordDesktopScreenWidget(context, constraints) {
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
                      child: _forgotPasswordMobileScreenWidget(
                          context, constraints))
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

  Widget _forgotPasswordMobileScreenWidget(context, constraints) {
    return Builder(builder: (context) {
      return Container(
        height: context.height,
        child: Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: kSpacing),
                  const SizedBox(height: kSpacing * 2),
                  const Padding(padding: EdgeInsets.all(12)),
                  Text('Forgot Password'),
                  const Padding(padding: EdgeInsets.all(12)),
                  const Padding(padding: EdgeInsets.all(12)),
                  const Padding(padding: EdgeInsets.all(12)),
                  _EmailInput(),
                  const Padding(padding: EdgeInsets.all(12)),
                  Padding(
                    padding: const EdgeInsets.only(top: kSpacing),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      // spacing: ,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kSpacing / 2),
                          child: _NewAcctButton(),
                        ),
                        const SizedBox(width: kSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kSpacing / 2),
                          child: _FPFButton(),
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      );
    });
  }
}

class _FPFButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: const Text('Submit'),
                onPressed: state.emailI.valid
                    ? () {
                        context.read<ForgotPasswordCubit>().submit();
                      }
                    : null,
              );
      },
    );
  }
}

class _NewAcctButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Theme.of(context).cardColor),
          key: const Key('loginForm_linktosignup_raisedButton'),
          child: Text(
            'New account?',
            style: TextStyle(color: Theme.of(context).textTheme.caption?.color),
          ),
          onPressed: () {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationStatusChanged(AuthenticationStatus.signup));
          },
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) =>
              context.read<ForgotPasswordCubit>().newEmail(email),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText:
                state.emailI.valid && !GetUtils.isEmail(state.emailI.value)
                    ? 'invalid email'
                    : null,
          ),
        );
      },
    );
  }
}
