
abstract class AdminStates {}

class AdminInitState extends AdminStates {}

class GetUserLoadingState extends AdminStates{}
class GetUserSuccessState extends AdminStates{}
class GetUserErrorState extends AdminStates{}

class GetDoctorLoadingState extends AdminStates{}
class GetDoctorSuccessState extends AdminStates{}
class GetDoctorErrorState extends AdminStates{}

class GetStudentLoadingState extends AdminStates{}
class GetStudentSuccessState extends AdminStates{}
class GetStudentErrorState extends AdminStates{}

class ChangeUserStatusSuccessState extends AdminStates{}
class ChangeUserStatusErrorState extends AdminStates{}
