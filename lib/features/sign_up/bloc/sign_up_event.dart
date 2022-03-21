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
  SignUpPasswordChanged(this.newPassword);

  final String newPassword;
}

class SignUpNameChanged extends SignUpEvent {
  SignUpNameChanged(this.newName);

  final String newName;
}

class SignUpPaytagChanged extends SignUpEvent {
  SignUpPaytagChanged(this.newPaytag);

  final String newPaytag;
}

class SignUpEmailChanged extends SignUpEvent {
  SignUpEmailChanged(this.newEmail);

  final String newEmail;
}

class SignUpCountryChanged extends SignUpEvent {
  SignUpCountryChanged(this.newCountry);

  final Country newCountry;
}

class SignUpTransferPinChanged extends SignUpEvent {
  SignUpTransferPinChanged(this.transferPin);

  final String transferPin;
}

class SignUpSubmitted extends SignUpEvent {
  SignUpSubmitted();
}
