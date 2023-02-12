
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
class GetDoctorForRateLoadingState extends StudentStates {}
class GetDoctorForRateSuccessState extends StudentStates {}
class GetDoctorForRateErrorState extends StudentStates {}
class RateSuccessState extends StudentStates {}
class RateErrorState extends StudentStates {}

class GetAllGroupSessionLoadingState extends StudentStates {}
class GetAllGroupSessionSuccessState extends StudentStates {}
class GetAllGroupSessionErrorState extends StudentStates {}
class ChangeGenderState extends StudentStates{}
class GetAppointmentDateState extends StudentStates {}
class GetAppointmentTimeState extends StudentStates {}

class BookGroupSessionSuccessState extends StudentStates {}
class BookGroupSessionErrorState extends StudentStates {}

class UnBookGroupSessionSuccessState extends StudentStates {}
class UnBookGroupSessionErrorState extends StudentStates {}

class EditImageSuccessState extends StudentStates {}
class EditImageErrorState extends StudentStates {}

class PikImageSuccessState extends StudentStates {}
class PikImageErrorState extends StudentStates {}

class UpdateStudentLoadingState extends StudentStates{}
class UpdateStudentSuccessState extends StudentStates{}
class UpdateStudentErrorState extends StudentStates{}
// previous session
class GetOnlineAppointmentLoadingState extends StudentStates{}
class GetOnlineAppointmentSuccessState extends StudentStates{}
class GetOnlineAppointmentErrorState extends StudentStates{}
class GetOfflineAppointmentLoadingState extends StudentStates{}
class GetOfflineAppointmentSuccessState extends StudentStates{}
class GetOfflineAppointmentErrorState extends StudentStates{}

class ChangeRateStatusSuccessState extends StudentStates{}
class ChangeRateStatusErrorState extends StudentStates{}
class GetRateState extends StudentStates{}
class DeletePhotoState extends StudentStates{}


class BookingDateSuccessState extends StudentStates{}
class BookingDateErrorState extends StudentStates{}


class GetBookingDateSuccessState extends StudentStates{}
class GetBookingDateErrorState extends StudentStates{}

class FindBookingDateState extends StudentStates{}