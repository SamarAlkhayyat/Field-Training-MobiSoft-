import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:login_screen/firebase_options.dart';

import 'login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/cubit/login_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import '../business_logic/cubit/captcha_cubit.dart';
import '../data/repositories/login_repository.dart';
import '../data/web_services/login_web_services.dart';
import '../data/repositories/captcha_repository.dart';
import 'package:login_screen/data/web_services/captcha_web_services.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options:DefaultFirebaseOptions.currentPlatform
//   );
//
//   runApp(const App());
// }
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final captchaRepository = CaptchaRepository(CaptchaWebServices());
    final loginRepository = LoginRepository(LoginWebServices());
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    // Request permissions for iOS devices
    firebaseMessaging.requestPermission();

    // Subscribe to a topic
    firebaseMessaging.subscribeToTopic('test_topic').then((_) {
      print('Subscribed to topic: test_topic');
    });

    // Get the token for this device
    firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      print("FCM Token: $token");
    });

    // Configure foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(notification.title!),
              content: Text(notification.body!),
            );
          },
        );
      }
    });

    // Handle background messages
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Handle the message when the app is brought to the foreground
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CaptchaCubit(captchaRepository),
          child: const LoginScreen(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(loginRepository),
          child: const LoginScreen(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("تسجيل دخول"),
                foregroundColor: Colors.white,
                backgroundColor: Color(0xff9a1616),
                actions: [
                  IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  )
                ],
              ),
              body: BlocProvider(
                create: (context) => CaptchaCubit(captchaRepository),
                child: const LoginScreen(),
              )
          )
      ),
    );
  }
}