import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/cubit/captcha_cubit.dart';
import '../data/repositories/captcha_repository.dart';
import '../data/web_services/captcha_web_services.dart';
import 'form.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final captchaRepository = CaptchaRepository(CaptchaWebServices());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CaptchaCubit(captchaRepository),
          child: const form()
        ),
      ],
      child: MaterialApp(
        home: form()
      )
    );
  }
}