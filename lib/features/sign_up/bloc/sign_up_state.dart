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
    this.paytagErrorUsageMessage = '',
  });

  final FormzStatus status;
  final TextInput name;
  final TextInput password;
  final TextInput email;
  final TextInput paytag;
  final String paytagErrorUsageMessage;
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
    String? paytagErrorUsageMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      paytag: paytag ?? this.paytag,
      transferPin: transferPin ?? this.transferPin,
      countryId: countryId ?? this.countryId,
      paytagErrorUsageMessage:
          paytagErrorUsageMessage ?? this.paytagErrorUsageMessage,
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
        paytagErrorUsageMessage,
      ];
}
