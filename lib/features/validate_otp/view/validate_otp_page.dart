import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:paylinc/features/validate_otp/cubit/validate_otp_cubit.dart';
import 'package:paylinc/features/validate_otp/view/validate_otp_form.dart';

class ValidateOtpPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ValidateOtpPage(), settings: routeSettings);
  }

  static final RouteSettings routeSettings =
      RouteSettings(name: "/validate-otp");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Validate Otp')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return ValidateOtpCubit();
          },
          child: ValidateOtpForm(),
        ),
      ),
    );
  }
}
