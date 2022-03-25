import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:paylinc/constants/app_constants.dart';
import 'package:paylinc/features/sign_up/sign_up.dart';
import 'package:paylinc/config/authentication/bloc/authentication_bloc.dart';
import 'package:paylinc/utils/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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

class EmailInputField extends StatelessWidget {
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
            errorText:
                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(state.email.value) &&
                        (state.email.value.toString().isNotEmpty)
                    ? 'invalid email'
                    : null,
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
          initialValue: kCountry.countryName,
          // initialValue: state.countryId.value,
          key: const Key('signUpForm_countryInput_textField'),
          onChanged: (country) =>
              context.read<SignUpBloc>().add(SignUpCountryChanged(kCountry)),
          decoration: InputDecoration(
            labelText: 'country',
            enabled: false,
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

class PaytagInput extends StatefulWidget {
  @override
  State<PaytagInput> createState() => _PaytagInputState();
}

class _PaytagInputState extends State<PaytagInput> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              initialValue: state.paytag.value,
              onChanged: (paytag) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  context.read<SignUpBloc>().add(SignUpPaytagChanged(paytag));
                });
              },
              decoration: InputDecoration(
                labelText: 'Paytag',
                errorStyle: TextStyle(color: kDangerColor),
                errorText: state.paytag.invalid ? 'invalid paytag' : null,
              ),
            ),
            state.paytag.valid
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      state.paytagUsageMessage,
                      style: _paytagMessageStyle(state),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }

  TextStyle? _paytagMessageStyle(SignUpState state) {
    if (state.paytagUsageMessage == "") {
      return null;
    }

    if (state.paytagUsageMessage == "available") {
      return TextStyle(color: kNotifColor);
    } else if (state.paytagUsageMessage == "checking . . .") {
      return TextStyle(color: kNotifColor);
    } else {
      return TextStyle(color: Theme.of(Get.context!).errorColor);
    }
  }
}

class TransferPinInput extends StatefulWidget {
  @override
  State<TransferPinInput> createState() => _TransferPinInputState();
}

class _TransferPinInputState extends State<TransferPinInput> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      // buildWhen: (previous, current) =>
      //     previous.transferPin.value != current.transferPin.value,
      builder: (context, state) {
        return PinCodeTextField(
          appContext: context,
          length: 6,
          obscureText: true,
          animationType: AnimationType.fade,
          animationDuration: Duration(milliseconds: 300),
          errorAnimationController: errorController,
          keyboardType: TextInputType.number,
          controller: textEditingController,
          onChanged: (value) {
            if (!canBeInteger(value) && (value.isNotEmpty)) {
              errorController.add(ErrorAnimationType.shake);
            }
            context.read<SignUpBloc>().add(SignUpTransferPinChanged(value));
            setState(() {
              textEditingController.text = value;
            });
          },
          beforeTextPaste: (text) => true,
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
                onPressed: () {
                  context.read<SignUpBloc>().add(SignUpSubmitted());
                },
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
