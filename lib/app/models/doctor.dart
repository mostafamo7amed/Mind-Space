class Doctor{
  String? id;
  String? name;
  String? dateOfBirth;
  String? department;
  String? gender;
  String? email;
  String? phone;
  String? image;
  bool? isBlocked;
  double? rate;

  Doctor(this.id, this.name, this.dateOfBirth, this.department, this.gender,
      this.email, this.phone, this.image,this.isBlocked,this.rate);


  Doctor.fromMap(Map<String,dynamic> map){
    id = map['id'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    image = map['image'];
    dateOfBirth = map['dateOfBirth'];
    gender = map['gender'];
    department = map['department'];
    isBlocked = map['isBlocked'];
    rate = map['rate'];
  }

  Map<String,dynamic>? toMap(){
    return {
      'id':id,
      'name':name,
      'email':email,
      'phone':phone,
      'image':image,
      'dateOfBirth':dateOfBirth,
      'gender':gender,
      'department':department,
      'isBlocked':isBlocked,
      'rate':rate,
    };
  }
}