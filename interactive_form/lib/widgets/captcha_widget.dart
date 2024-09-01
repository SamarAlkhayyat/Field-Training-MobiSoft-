import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/cubit/captcha_cubit.dart';
import '../data/models/captcha.dart';
import '../data/models/question.dart';

class CaptchaWidget extends StatefulWidget {
  final Question question;

  const CaptchaWidget({super.key, required this.question});

  @override
  State<CaptchaWidget> createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {

  @override
  void initState(){
    super.initState();
    BlocProvider.of<CaptchaCubit>(context).generateCaptcha();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.question.isEnabled){
      return captchaForm();
    }
    else {
      return AbsorbPointer(
          absorbing: true,
          child: Opacity(
            opacity: 0.5,
            child: captchaForm(),
          )
      );
    }
  }

  Widget captchaForm(){
    final _captchaController = TextEditingController();
    Captcha? _captcha;

    return BlocBuilder<CaptchaCubit, CaptchaState>(
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
                decoration: InputDecoration(
                  label: Text(widget.question.name,
                    style: TextStyle(color: widget.question.isEnabled? Colors.black : Colors.grey, fontSize: 16),
                  ),
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
    );
  }
}


