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
  String? status;
  bool? isRated;
  String? doctorReport;
  String? doctorName;

  AppointmentModel(this.appointmentId, this.studentId, this.accountType,
      this.date, this.time, this.link, this.type, this.doctorId,this.studentNickname,this.status,this.doctorReport,this.isRated,this.doctorName);

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
    status = map['status'];
    doctorReport = map['doctorReport'];
    isRated = map['isRated'];
    doctorName = map['doctorName'];
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
      'status': status,
      'doctorReport': doctorReport,
      'isRated':isRated,
      'doctorName':doctorName,
    };
  }
}
