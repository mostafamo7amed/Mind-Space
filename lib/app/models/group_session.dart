class GroupSessionModel {
  String? groupId;
  String? title;
  String? description;
  String? date;
  String? time;
  String? link;
  String? status;
  String? doctorName;
  double? doctorRate;
  String? doctorId;

  GroupSessionModel(this.groupId,this.title, this.description, this.date, this.time, this.link,
      this.status, this.doctorName, this.doctorRate,this.doctorId);

  GroupSessionModel.fromMap(Map<String,dynamic> map){
    title = map['title'];
    description = map['description'];
    date = map['date'];
    time = map['time'];
    link = map['link'];
    status = map['status'];
    doctorName = map['doctorName'];
    doctorRate = map['doctorRate'];
    groupId = map['groupId'];
    doctorId = map['doctorId'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'title':title,
      'description':description,
      'date':date,
      'time':time,
      'link':link,
      'status':status,
      'doctorName':doctorName,
      'doctorRate':doctorRate,
      'groupId':groupId,
      'doctorId':doctorId,
    };
  }
}