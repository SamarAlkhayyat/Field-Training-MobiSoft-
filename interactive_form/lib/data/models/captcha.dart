import 'dart:convert';

class Captcha {
  late dynamic img;
  late String value;

  Captcha.fromJson(Map<String, dynamic> json){
    img = base64Decode(json['Img']);
    value = json['Guid'];
  }
}