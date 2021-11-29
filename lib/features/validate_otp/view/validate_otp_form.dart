import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylinc/features/validate_otp/cubit/validate_otp_cubit.dart';
import 'package:paylinc/config/authentication/bloc/authentication_bloc.dart';

class ValidateOtpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ValidateOtpCubit, ValidateOtpState>(
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
            _OtpInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _SubmitButton(),
            const Padding(padding: EdgeInsets.all(12)),
            _NewAcctButton(),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidateOtpCubit, ValidateOtpState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('fpForm_continue_raisedButton'),
                child: const Text('Submit'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<ValidateOtpCubit>().submit();
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

class _OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidateOtpCubit, ValidateOtpState>(
      buildWhen: (previous, current) => previous.otp != current.otp,
      builder: (context, state) {
        return TextField(
          key: const Key('votpForm_otpInput_textField'),
          onChanged: (otp) => context.read<ValidateOtpCubit>().newOtp(otp),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Otp',
            errorText: state.otp.invalid ? 'invalid otp' : null,
          ),
        );
      },
    );
  }
}
