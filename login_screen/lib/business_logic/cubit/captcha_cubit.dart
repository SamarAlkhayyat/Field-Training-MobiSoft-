import 'package:bloc/bloc.dart';
import '../../data/models/captcha.dart';
import '../../data/repositories/captcha_repository.dart';

part 'captcha_state.dart';

class CaptchaCubit extends Cubit<CaptchaState> {
  final CaptchaRepository captchaRepository;

  CaptchaCubit(this.captchaRepository) : super(CaptchaInitial());

  Future<Captcha> generateCaptcha() async {
    final captcha = await captchaRepository.generateCaptcha();
    emit(CaptchaLoaded(captcha));
    return captcha;
  }
}
