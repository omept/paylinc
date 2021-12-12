import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:paylinc/config/authentication/authentication.dart';
import 'package:paylinc/config/routes/app_pages.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/login/login.dart';
import 'package:paylinc/shared_components/project_card.dart';
import 'package:paylinc/shared_components/project_card_data.dart';
import 'package:paylinc/shared_components/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: _loginPageMobileScreenWidget,
          tabletBuilder: _loginPageDesktopScreenWidget,
          desktopBuilder: _loginPageDesktopScreenWidget,
        ),
      ),
      // }
    );
  }

  Widget _loginPageDesktopScreenWidget(context, constraints) {
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
                      child: _loginPageMobileScreenWidget(context, constraints))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginPageMobileScreenWidget(context, constraints) {
    return Padding(
      padding: const EdgeInsets.all(kSpacing),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
            const SizedBox(height: kSpacing / 2),
            const SizedBox(height: kSpacing * 2),
            const Padding(padding: EdgeInsets.all(12)),
            Text('Log in'),
            const SizedBox(height: kSpacing * 2),
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(child: _LoginButton()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: kSpacing),
              child: Wrap(
                alignment: WrapAlignment.center,
                // spacing: ,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kSpacing / 2),
                    child: _NewAcctButton(),
                  ),
                  const SizedBox(width: kSpacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kSpacing / 2),
                    child: ElevatedButton(
                      child: const Text('Forgot Password?'),
                      onPressed: () {
                        Get.offNamed(Routes.forgot_password);
                      },
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'username',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Login'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
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
    return ElevatedButton(
      child: const Text('New account?'),
      onPressed: () {
        context
            .read<AuthenticationBloc>()
            .add(AuthenticationStatusChanged(AuthenticationStatus.signup));
      },
    );
  }
}
