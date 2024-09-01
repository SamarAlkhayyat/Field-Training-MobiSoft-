import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_form/data/models/question.dart';
import '../business_logic/cubit/captcha_cubit.dart';
import '../utils/form_utils.dart';

class form extends StatefulWidget {
  const form({super.key});

  @override
  State<form> createState() => _formState();
}

enum gender{Male, Female}

class _formState extends State<form> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  final List<Question> QuestionsList1 = [
    Question(
        name: 'اسم المؤسسة:',
        type: QType.TextValue,
        isMandatory: true,
        isEnabled: true,
        isVisible: true,
        numericalKeyboardType: false
    ),
    Question(
      name: 'معلومات العنوان:',
      type: QType.TextValue,
      isMandatory: false,
      isEnabled: true,
      isVisible: true,
      numericalKeyboardType: false
    )
  ];
  final List<Question> QuestionsList2 = [
    Question(
        name: 'البريد الإلكتروني (اسم المستخدم):',
        type: QType.TextValue,
        isMandatory: true,
        isEnabled: true,
        isVisible: true,
        numericalKeyboardType: false
    ),
    Question(
        name: 'تأكيد البريد الإلكتروني (اسم المستخدم):',
        type: QType.TextValue,
        isMandatory: true,
        isEnabled: true,
        isVisible: true
    ),
    Question(
        name: 'رمز المرور الجديد:',
        type: QType.TextValue,
        isMandatory: true,
        isEnabled: true,
        isVisible: true,
        numericalKeyboardType: false
    ),
    Question(
        name: 'تأكيد رمز المرور الجديد:',
        type: QType.TextValue,
        isMandatory: true,
        isEnabled: true,
        isVisible: true,
        numericalKeyboardType: false
    ),
    Question(
        name: 'رقم الهاتف:',
        type: QType.TextValue,
        isMandatory: true,
        isEnabled: true,
        isVisible: true,
        numericalKeyboardType: true
    ),
    Question(
      name: 'أدخل الرمز الموجود في الصورة:',
      type: QType.CAPTCHA,
      isMandatory: true,
      isEnabled: true,
      isVisible: true,
      numericalKeyboardType: false
    )
  ];

  @override
  void initState(){
    super.initState();
    BlocProvider.of<CaptchaCubit>(context).generateCaptcha();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informative form'),
        foregroundColor: Colors.black,
        backgroundColor: Colors.blueGrey,
      ),
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            FormPage1(),
            FormPage2()
          ],
        )
      )
    );
  }
  Widget FormPage1(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormPage(
          questions: QuestionsList1,
          pageController: _pageController
        ),
        Center(
          child: NextButton(
            key: _formKey,
            pageController: _pageController,
            scaffoldContext: context
          ),
        ),
        SizedBox(height: 50)
      ],
    );
  }

  Widget FormPage2(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormPage(
          questions: QuestionsList2,
          pageController: _pageController
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFormBackButton(pageController: _pageController),
              SizedBox(width: 10),
              SubmitButton(
                key: _formKey,
                pageController: _pageController,
                scaffoldContext: context
              ),
            ],
          )
        ),
        SizedBox(height: 50)
      ],
    );
  }
}