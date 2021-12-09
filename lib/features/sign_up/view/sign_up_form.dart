import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paylinc/features/sign_up/sign_up.dart';
import 'package:paylinc/config/authentication/bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //     const SnackBar(content: Text('Authentication Failure')),
          //   );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            SignUpButton(),
            const Padding(padding: EdgeInsets.all(12)),
            PrevAcctButton(),
          ],
        ),
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.name.value,
          key: const Key('signUpForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<SignUpBloc>().add(SignUpNameChanged(name)),
          decoration: InputDecoration(
            labelText: 'name',
            errorText: state.name.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<SignUpBloc>().add(SignUpEmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'email',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class CountryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.countryId != current.countryId,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.countryId.value,
          key: const Key('signUpForm_countryInput_textField'),
          onChanged: (country) => context.read<SignUpBloc>().add(
              SignUpCountryChanged(
                  Country(countryId: 123, countryName: "Nigeria"))),
          decoration: InputDecoration(
            labelText: 'country',
            errorText: state.countryId.invalid ? 'invalid country' : null,
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpBloc>().add(SignUpPasswordChanged(password)),
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

class PaytagInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.paytag != current.paytag,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.paytag.value,
          key: const Key('signUpForm_paytagInput_textField'),
          onChanged: (paytag) =>
              context.read<SignUpBloc>().add(SignUpPaytagChanged(paytag)),
          decoration: InputDecoration(
            labelText: 'Paytag',
            errorText: state.paytag.invalid ? 'invalid paytag' : null,
          ),
        );
      },
    );
  }
}

class TransferPinInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.transferPin != current.transferPin,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.transferPin.value,
          key: const Key('signUpForm_transferPinInput_textField'),
          onChanged: (transferPin) => context
              .read<SignUpBloc>()
              .add(SignUpTransferPinChanged(transferPin)),
          decoration: InputDecoration(
            labelText: 'transfer pin',
            errorText: state.transferPin.invalid ? 'invalid tranfer' : null,
          ),
        );
      },
    );
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signupForm_continue_raisedButton'),
                child: const Text('Sign Up'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<SignUpBloc>().add(SignUpSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}

class PrevAcctButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('signupForm_linktologin_raisedButton'),
          child: const Text('old account?'),
          onPressed: () {
            context.read<AuthenticationBloc>().add(AuthenticationStatusChanged(
                AuthenticationStatus.unauthenticated));
          },
        );
      },
    );
  }
}
