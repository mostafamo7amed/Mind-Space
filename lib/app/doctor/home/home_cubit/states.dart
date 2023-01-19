
abstract class DoctorStates {}

class DoctorInitState extends DoctorStates {}

class DoctorBottomNavState extends DoctorStates {}
class ChangeGroupSessionStatusState extends DoctorStates {}


class GetDoctorLoadingState extends DoctorStates {}
class GetDoctorSuccessState extends DoctorStates {}
class GetDoctorErrorState extends DoctorStates {}

class EditImageSuccessState extends DoctorStates {}
class EditImageErrorState extends DoctorStates {}

class PikImageSuccessState extends DoctorStates {}
class PikImageErrorState extends DoctorStates {}

class UpdateDoctorLoadingState extends DoctorStates{}
class UpdateDoctorSuccessState extends DoctorStates{}
class UpdateDoctorErrorState extends DoctorStates{}

class AddGroupSessionLoadingState extends DoctorStates{}
class AddGroupSessionSuccessState extends DoctorStates{}
class AddGroupSessionErrorState extends DoctorStates{}

class GetGroupSessionLoadingState extends DoctorStates{}
class GetGroupSessionSuccessState extends DoctorStates{}
class GetGroupSessionErrorState extends DoctorStates{}

class EditGroupSessionLoadingState extends DoctorStates{}
class EditGroupSessionSuccessState extends DoctorStates{}
class EditGroupSessionErrorState extends DoctorStates{}

class DeleteGroupSessionSuccessState extends DoctorStates{}
class DeleteGroupSessionErrorState extends DoctorStates{}