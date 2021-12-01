import 'package:authentication_repository/authentication_repository.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:paylinc/config/authentication/authentication.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:paylinc/shared_components/header.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';
import 'package:paylinc/shared_components/today_text.dart';

class ForgotPasswordPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ForgotPasswordPage(), settings: routeSettings);
  }

  static final RouteSettings routeSettings =
      RouteSettings(name: "/forgot-password");

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text('Forgot Password')),
  //     body: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: ForgotPasswordForm(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: _forgotPasswordMobileScreenWidget,
          tabletBuilder: _forgotPasswordTabletScreenWidget,
          desktopBuilder: _forgotPasswordDesktopScreenWidget,
        ),
      ),
      // }
    );
  }

  Widget _forgotPasswordDesktopScreenWidget(context, constraints) {
    var maxWidth = 1360;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: (constraints.maxWidth < maxWidth) ? 4 : 3,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(kBorderRadius),
                bottomRight: Radius.circular(kBorderRadius),
              ),
              child: Container()),
        ),
        Flexible(
          flex: 9,
          child: Column(
            children: [
              const SizedBox(height: kSpacing),
              _buildHeader(context: context),
              const SizedBox(height: kSpacing * 2),
              const Padding(padding: EdgeInsets.all(12)),
              Text('Forgot Password'),
              const Padding(padding: EdgeInsets.all(12)),
              const Padding(padding: EdgeInsets.all(12)),
              const Padding(padding: EdgeInsets.all(12)),
              _EmailInput(),
              const Padding(padding: EdgeInsets.all(12)),
              _FPFButton(),
              const Padding(padding: EdgeInsets.all(12)),
              _NewAcctButton(),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: kSpacing / 2),
              Text('Welcome Page'),
              const Divider(thickness: 1),
              const SizedBox(height: kSpacing),
            ],
          ),
        )
      ],
    );

    // return Container();
  }

  ProjectCardData getSelectedProject() {
    return ProjectCardData(
      percent: .3,
      projectImage: const AssetImage(ImageRasterPath.logo1),
      projectName: "Paylinc",
      releaseTime: DateTime.now(),
    );
  }

  Widget _forgotPasswordTabletScreenWidget(context, constraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: (constraints.maxWidth < 950) ? 6 : 9,
          child: Column(
            children: [
              const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
              const SizedBox(height: kSpacing * 2),
              const SizedBox(height: kSpacing * 2),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: kSpacing * (kIsWeb ? 0.5 : 1.5)),
            ],
          ),
        )
      ],
    );
  }

  Widget _forgotPasswordMobileScreenWidget(context, constraints) {
    return Column(children: [
      const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
      const SizedBox(height: kSpacing / 2),
      const Divider(),
    ]);
  }

  Widget _buildHeader({Function()? onPressedMenu, context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          Row(
            children: [
              if (onPressedMenu != null)
                Padding(
                  padding: const EdgeInsets.only(right: kSpacing),
                  child: IconButton(
                    onPressed: onPressedMenu,
                    icon: const Icon(EvaIcons.menu),
                    tooltip: "menu",
                  ),
                ),
              const Expanded(
                  child: Header(
                todayText: TodayText(message: "Welcome Page"),
              )),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                child: const Text('middle column '),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
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
                key: const Key('fpForm_continue_raisedButton'),
                child: const Text('Submit'),
                onPressed: state.status.isValidated
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
          key: const Key('loginForm_linktosignup_raisedButton'),
          child: const Text('new account?'),
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
      buildWhen: (previous, current) => previous.emailI != current.emailI,
      builder: (context, state) {
        return TextField(
          key: const Key('fpForm_EmailInput_textField'),
          onChanged: (password) =>
              context.read<ForgotPasswordCubit>().newEmail(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.emailI.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}
