import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylinc/authentication/authentication.dart';
import 'package:paylinc/forgot_password/forgot_password.dart';

class ForgotPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sending Failed.')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.all(12)),
            _EmailInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _FPFButton(),
            const Padding(padding: EdgeInsets.all(12)),
            _NewAcctButton(),
          ],
        ),
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
                        context.read<AuthenticationBloc>().add(AuthenticationStatusChanged(AuthenticationStatus.signup));
                      }
                    ,
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