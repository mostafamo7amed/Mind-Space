class BookingDate {
  String? date;
  String? time;

  BookingDate(this.date, this.time,);

  BookingDate.fromMap(Map<String,dynamic> map){
    date = map['date'];
    time = map['time'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'date':date,
      'time':time,
    };
  }
}