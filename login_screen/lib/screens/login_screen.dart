import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/data/models/captcha.dart';
import 'package:login_screen/business_logic/cubit/login_cubit.dart';
import 'package:login_screen/business_logic/cubit/captcha_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _captchaController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Captcha? _captcha;

  @override
  void initState(){
    super.initState();
    BlocProvider.of<CaptchaCubit>(context).generateCaptcha();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
            padding: EdgeInsets.all(10),
            children: [ Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(image: NetworkImage("https://th.bing.com/th/id/OIP.2yUY3BW3TUSLzqgI7ne6HQHaD4?rs=1&pid=ImgDetMain")),
                Center(
                    child: Text("بوابة الخدمات الإلكترونية لوزارة الداخلية",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    )
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("اسم المستخدم",
                          style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                        )],
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: "اسم المستخدم",
                          prefixIcon: Icon(Icons.person, color: Color(0xff9a1616)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Color(0xff9a1616)),
                          ),
                        ),
                        validator: (value) {
                          if(value!.isEmpty)
                            return "الرجاء إدخال اسم المستخدم";
                          else
                            return null;
                        },
                      ), //اسم المستخدم
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("رمز المرور",
                          style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                        )],
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "رمز المرور",
                          prefixIcon: Icon(Icons.lock, color: Color(0xff9a1616)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Color(0xff9a1616)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Color(0xff9a1616)),
                          ),
                        ),
                        validator: (value) {
                          if(value!.isEmpty)
                            return "الرجاء إدخال رمز المرور";
                          else
                            return null;
                        },
                      ), //رمز المرور
                      SizedBox(height: 10),
                      BlocBuilder<CaptchaCubit, CaptchaState>(
                        builder: (context, state) {
                          if(state is CaptchaLoaded) {
                            _captchaController.clear();
                            _captcha = state.captcha;
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      child: ElevatedButton(
                                        child: Icon(Icons.refresh, color: Colors.grey,),
                                        onPressed: () {
                                          BlocProvider.of<CaptchaCubit>(context).generateCaptcha();
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: WidgetStateProperty.all<Color>(Colors.white70),
                                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Image.memory(_captcha!.img,height: 60,)
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _captchaController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(color: Color(0xff9a1616)),
                                    ),
                                    hintText: "أدخل الرمز الموجود في الصورة",
                                  ),
                                  validator: (value) {
                                    if(value!.isEmpty)
                                      return "أدخل الرمز الموجود في الصورة";
                                  },
                                ),
                              ],
                            );
                          }
                          else {
                            return Center(
                              child: CircularProgressIndicator(color: Colors.grey)
                            );
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          child: Text(
                            "تسجيل الدخول",
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Color(0xff9a1616)),
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final loginCubit = context.read<LoginCubit>();
                              loginCubit.login(
                                username: _usernameController.text,
                                password: _passwordController.text,
                                captchaCode: _captchaController.text,
                                captchaGUID: _captcha!.value,
                              );
                              SnackBar snackBar = SnackBar(content: Text("Welcome"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              //TODO: navigation
                            }
                          },
                        ),
                      ),
                      TextButton(
                        child: Text(
                          "نسيت رمز المرور ؟",
                          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                        onPressed: () {
                          // TODO: implement
                        },
                      ),
                      SizedBox(
                        width: double.infinity, // Makes the button fill the available width
                        height: 60, // Set a fixed height for the button
                        child: ElevatedButton(
                          child: Text(
                            "إنشاء حساب جديد",
                            style: TextStyle(fontSize: 18, color: Color(0xff9a1616), fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Color(0xff9a1616))
                              ),
                            ),
                          ),
                          onPressed: () {
                            // TODO: navigation
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )]
        )
    );
  }
}
