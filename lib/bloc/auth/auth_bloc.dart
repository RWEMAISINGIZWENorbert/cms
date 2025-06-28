import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tech_associate/data/repositories/auth_repository.dart';
import 'package:tech_associate/utils/connectivity_utils.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_oSignUp);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      bool isConnected = await hasInternetConnection();
      if (isConnected) {
        await authRepository.login(
          email: event.emailAdress,
          password: event.password,
        );
        
        // Verify that login was successful by checking if we have a token
        final token = await authRepository.getAccessToken();
        if (token != null) {
          emit(AuthSuccessState(sucessMsg: "Login successfully"));
        } else {
          emit(const AuthFailState(failMsg: 'Login failed - no token received'));
        }
      } else {
        emit(const AuthFailState(failMsg: 'Check your internet connection'));
      }
    } catch (e) {
      emit(AuthFailState(failMsg: e.toString()));
    }
  }

  Future<void> _oSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
      emit(AuthLoadingState());
      try {
          
          bool isConnected = await hasInternetConnection();
        if(isConnected){
        final msg = await authRepository.signUp(
        email: event.email,
        userName: event.userName,
        department: event.department,
        telephone: event.telephone,
        password: event.password,
        cPassword: event.cPassword,
      );
      emit(AuthSuccessState(sucessMsg: msg));
          }else{
            emit(const AuthFailState(failMsg: 'Check your internet connection'));
          }

      } catch (e) {
        emit(AuthFailState(failMsg: 'Error occured $e'));
      }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
     try {
     await authRepository.logout();
     emit(const LogoutSuccessState(sucessMsg: 'Logged out successfully!'));    
     } catch (e) {
       emit(AuthFailState(failMsg: 'Error occured $e'));
     }
  }
}
