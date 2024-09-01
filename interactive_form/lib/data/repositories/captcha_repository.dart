import 'package:interactive_form/data/web_services/captcha_web_services.dart';
import '../models/captcha.dart';

class CaptchaRepository {
  final CaptchaWebServices captchaWebServices;

  CaptchaRepository(this.captchaWebServices);

  Future<Captcha> generateCaptcha() async{
    final captchaData = await captchaWebServices.generateCaptcha();

    print("response data in rep ${captchaData}");
    if (captchaData.isEmpty) {
      throw Exception('Received empty data from captchaWebServices');
    }

    return Captcha.fromJson(captchaData);
  }
}