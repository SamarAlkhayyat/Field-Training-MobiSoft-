part of 'captcha_cubit.dart';

abstract class CaptchaState {
  List<Object?> get props => [];
}

class CaptchaInitial extends CaptchaState {}

class CaptchaLoaded extends CaptchaState {
  final Captcha captcha;

  CaptchaLoaded(this.captcha);

  @override
  List<Object> get props => [captcha];
}