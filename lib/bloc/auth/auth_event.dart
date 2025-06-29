
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
    final String emailAdress;
    final String password; 

    const SignInEvent({required this.emailAdress, required this.password});  
}

class SignUpEvent extends AuthEvent {
     
   final   String email;
   final   String userName;
   final String department;
   final  String password;
   final  String cPassword;
   final int telephone;


  const  SignUpEvent({
    required this.email, 
    required this.userName, 
    required this.department,
    required this.telephone,
    required this.password, 
    required this.cPassword, 
    });
} 

class LogoutEvent extends AuthEvent {
   const LogoutEvent();
}

class LoadCurrentUserData extends AuthEvent {}