abstract class AuthStates{}
class IntialState extends AuthStates{}
class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{}
class RegisterFailedState extends AuthStates{
  String ?message;
  RegisterFailedState({
    required this.message
  });
}
class LogInLoadingState extends AuthStates{}
class LogInSuccessState extends AuthStates{}
class LogInFailedState extends AuthStates{
  String ?message;
  LogInFailedState({
    required this.message
});
}