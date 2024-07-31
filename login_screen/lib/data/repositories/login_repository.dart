import 'package:login_screen/data/web_services/login_web_services.dart';

class LoginRepository {
  final LoginWebServices loginWebServices;

  LoginRepository(this.loginWebServices);

  Future<Map<String, dynamic>> login(Map<String, dynamic> loginData) async {
    return await loginWebServices.login(loginData);
  }
}