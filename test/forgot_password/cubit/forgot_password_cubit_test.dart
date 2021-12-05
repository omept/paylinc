import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paylinc/features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:paylinc/shared_components/form_inputs/email.dart';

void main() {
  group(ForgotPasswordCubit(), () {
    late ForgotPasswordCubit forgotPasswordCubit;

    //initialize the testing setup
    setUp(() {
      forgotPasswordCubit = ForgotPasswordCubit();
    });

    //dictates what will happen after the test finishes
    tearDown(() {
      forgotPasswordCubit.close();
    });

    test(
        "Initial state of forgotPasswordState is ForgotPasswordState(email: '')",
        () {
      expect(forgotPasswordCubit.state,
          ForgotPasswordState(emailI: EmailInput.pure()));
    });

    //test the cubits
    blocTest(
      "The cubit should emit a change state of ForgotPasswordState(email: 'admin@admin.com') when newEmail('admin@admin.com') is called",
      build: () => forgotPasswordCubit,
      act: (cubit) => forgotPasswordCubit.newEmail('admin@admin.com'),
      expect: () =>
          [ForgotPasswordState(emailI: EmailInput.dirty('admin@admin.com'))],
    );
  });
}
