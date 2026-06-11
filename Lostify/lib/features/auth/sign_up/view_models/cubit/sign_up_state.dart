part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpFailure extends SignUpState {
  final String message;
  SignUpFailure({required this.message});
}

final class PasswordNotMatch extends SignUpState {
  final String message = "Password not match";
}

final class AcceptTermsAndPolicy extends SignUpState {
  final String message = "Please accept terms and policy";
}

final class ChangeTermsAndPolicyState extends SignUpState {}
