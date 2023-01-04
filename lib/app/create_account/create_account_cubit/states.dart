abstract class CreateStates{}

class CreateUserIntiStates extends CreateStates{}

class CreateUserLoadingState extends CreateStates {}
class CreateUserSuccessState extends CreateStates {
  String uid;
  CreateUserSuccessState(this.uid);
}
class CreateUserErrorState extends CreateStates {}