
abstract class StudentStates {}

class StudentInitState extends StudentStates {}

class StudentBottomNavState extends StudentStates {}

class GetStudentLoadingState extends StudentStates {}
class GetStudentSuccessState extends StudentStates {}
class GetStudentErrorState extends StudentStates {}

class MakeAppointmentLoadingState extends StudentStates {}
class MakeAppointmentSuccessState extends StudentStates {}
class MakeAppointmentErrorState extends StudentStates {}

class GetDoctorLoadingState extends StudentStates {}
class GetDoctorSuccessState extends StudentStates {}
class GetDoctorErrorState extends StudentStates {}

class GetAppointmentDateState extends StudentStates {}
class GetAppointmentTimeState extends StudentStates {}