part of 'sign_up_bloc.dart';

abstract class SignUpEvent {
  SignUpEvent(
      {this.password,
      this.name,
      this.paytag,
      this.email,
      this.country,
      this.username});
  String? password;
  String? name;
  String? paytag;
  String? email;
  Country? country;
  String? username;
}

class SignUpPasswordChanged extends SignUpEvent {
  SignUpPasswordChanged(this.password);

  final String password;
}

class SignUpNameChanged extends SignUpEvent {
  SignUpNameChanged(this.name);

  final String name;
}

class SignUpPaytagChanged extends SignUpEvent {
  SignUpPaytagChanged(this.paytag);

  final String paytag;
}

class SignUpEmailChanged extends SignUpEvent {
  SignUpEmailChanged(this.email);

  final String email;
}

class SignUpCountryChanged extends SignUpEvent {
  SignUpCountryChanged(this.country);

  final Country country;
}

class SignUpTransferPinChanged extends SignUpEvent {
  SignUpTransferPinChanged(this.transferPin);

  final String transferPin;
}

class SignUpSubmitted extends SignUpEvent {
  SignUpSubmitted();
}
