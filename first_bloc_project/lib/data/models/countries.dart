class Country {
  late String char_id;
  late String employee_code;
  late String name;
  late String birthday;
  late String business_unit;
  late String job_title;
  late String hierarchy;
  late String email;
  late String mobile_number;
  late String gender;
  late String img;

  Country.fromJson(Map<String, dynamic> json){
    char_id = json['char_id'];
    employee_code = json['employee_code'];
    name = json['name'];
    job_title = json['Job_title'];
    birthday = json['birthday'];
    business_unit = json['business_unit'];
    hierarchy = json['hierarchy'];
    email = json['email'];
    mobile_number = json['mobile_number'];
    gender = json['gender'];
    img = json['img'];
  }
}