enum QType{Radio, CheckBox, TextValue, ComboBox, CAPTCHA}

class Question{
  String name;
  QType type;
  bool isMandatory;
  bool isEnabled;
  bool isVisible;
  bool numericalKeyboardType;
  List<dynamic> options;

  Question({
    required this.name,
    required this.type,
    required this.isMandatory,
    required this.isEnabled,
    required this.isVisible,
    this.numericalKeyboardType = false,
    this.options = const []
  });
}