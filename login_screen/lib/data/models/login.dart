class Login {
  late String username;
  late String password;
  late String captchaCode;
  late String captchaGUID;
  late String versionNumber;
  late String deviceType;

  Login({
    required this.username,
    required this.password,
    required this.captchaCode,
    required this.captchaGUID,
    required this.versionNumber,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Password': password,
      'CaptchaCode': captchaCode,
      'CaptchaGUID': captchaGUID,
      'VersionNumber': versionNumber,
      'DeviceType': deviceType,
    };
  }
}
