part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState { }

final class AuthFailState extends AuthState {
     final String failMsg;
     const AuthFailState({ required this.failMsg});
} 

final class AuthSuccessState extends AuthState {
   String sucessMsg;
    AuthSuccessState({ required this.sucessMsg});
}

final class LogoutSuccessState extends AuthState {
   final String sucessMsg;
   const LogoutSuccessState({ required this.sucessMsg });
}
final class LogoutFailState extends AuthState {
  final String failMsg;
   const LogoutFailState({required this.failMsg});
}