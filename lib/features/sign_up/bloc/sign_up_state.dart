part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzStatus.pure,
    this.name = const TextInput.pure(),
    this.email = const TextInput.pure(),
    this.password = const TextInput.pure(),
    this.paytag = const TextInput.pure(),
    this.transferPin = const TextInput.pure(),
    this.countryId = const TextInput.pure(),
    this.paytagUsageMessage = '',
  });

  final FormzStatus status;
  final TextInput name;
  final TextInput password;
  final TextInput email;
  final TextInput paytag;
  final String paytagUsageMessage;
  final TextInput transferPin;
  final TextInput countryId;

  SignUpState copyWith({
    FormzStatus? status,
    TextInput? name,
    TextInput? password,
    TextInput? email,
    TextInput? paytag,
    TextInput? transferPin,
    TextInput? countryId,
    String? paytagUsageMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      paytag: paytag ?? this.paytag,
      transferPin: transferPin ?? this.transferPin,
      countryId: countryId ?? this.countryId,
      paytagUsageMessage: paytagUsageMessage ?? this.paytagUsageMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        name,
        password,
        email,
        paytag,
        transferPin,
        countryId,
        paytagUsageMessage,
      ];
}
