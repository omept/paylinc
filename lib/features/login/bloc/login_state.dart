part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzStatus.pure,
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.message = ' '});

  final FormzStatus status;
  final Username username;
  final Password password;
  final String message;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, username, password, message];
}
