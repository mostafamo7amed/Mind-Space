class AppointmentModel {
  String? appointmentId;
  String? studentId;
  String? doctorId;
  String? accountType;
  String? studentNickname;
  String? date;
  String? time;
  String? link;
  String? type;

  AppointmentModel(this.appointmentId, this.studentId, this.accountType,
      this.date, this.time, this.link, this.type, this.doctorId,this.studentNickname);

  AppointmentModel.fromMap(Map<String, dynamic> map) {
    studentId = map['studentId'];
    accountType = map['accountType'];
    date = map['date'];
    time = map['time'];
    link = map['link'];
    type = map['type'];
    appointmentId = map['appointmentId'];
    doctorId = map['doctorId'];
    studentNickname = map['studentNickname'];
  }

  Map<String, dynamic>? toMap() {
    return {
      'studentId': studentId,
      'accountType': accountType,
      'date': date,
      'time': time,
      'link': link,
      'type': type,
      'appointmentId': appointmentId,
      'doctorId': doctorId,
      'studentNickname': studentNickname,
    };
  }
}
