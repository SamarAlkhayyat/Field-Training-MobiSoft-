import 'package:bloc/bloc.dart';
import 'package:login_screen/data/models/login.dart';
import 'package:login_screen/data/repositories/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit(this.loginRepository) : super(LoginInitial());

  Future<void> login({
    required String username,
    required String password,
    required String captchaCode,
    required String captchaGUID,
  }) async {
    try {
      final request = Login(
        username: username,
        password: password,
        captchaCode: captchaCode,
        captchaGUID: captchaGUID,
        versionNumber: '1.31', //or AppUtil.gerVerNumber()
        deviceType: 'Android',
      );
      final response = await loginRepository.login(request.toJson());
      if (response['success'] == true) {
        emit(LoginSuccess(response['message'] ?? 'Login successful'));
      } else {
        emit(LoginFailure(response['message'] ?? 'Login failed'));
      }
    }
    catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
