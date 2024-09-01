import 'package:flutter/material.dart';
import 'package:interactive_form/data/models/question.dart';
import '../widgets/checkBox_widget.dart';
import '../widgets/comboBox_widget.dart';
import '../widgets/radio_widget.dart';
import '../widgets/text_widget.dart';
import 'package:interactive_form/widgets/captcha_widget.dart';

Widget FormPage(
    {required List<Question> questions,
     required PageController pageController}
   ){
  return Expanded(
    child: ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemCount: questions.length,
      itemBuilder: (context, index){
        final question = questions[index];
        if(question.isVisible){
          switch(question.type){
            case QType.Radio:
              return RadioWidget(question: question, options: question.options,);
            case QType.CheckBox:
              return CheckBoxWidget(question: question, options: question.options.cast<String>());
            case QType.TextValue:
              return TextWidget(question: question);
            case QType.ComboBox:
              return ComboBoxWidget(question: question, dropDownList: question.options.cast<String>(),);
            case QType.CAPTCHA:
              return CaptchaWidget(question: question);
          }
        }
      },
    ),
  );
}

Widget NextButton(
  {required GlobalKey<FormState> key,
   required PageController pageController,
   required scaffoldContext}
  ){
  return ElevatedButton(
    child: Text('Next', style: TextStyle(color: Colors.black),),
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.blueGrey)
        ),
      ),
    ),
    onPressed: () {
      print('Current state of _formKey1: ${key.currentState}');
      if (key.currentState!.validate()) {
        key.currentState!.save();
        print('Current state of _formKey1: ${key.currentState}');
        pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        print('Current state of _formKey1: ${key.currentState}');
      }
      else {
        SnackBar snackBar = SnackBar(
          content: Text("Complete all fields",
              style: TextStyle(color: Colors.yellowAccent)
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
      }
    },
  );
}

Widget CustomFormBackButton({required PageController pageController}){
  return ElevatedButton(
    child: Text('Back', style: TextStyle(color: Colors.black),),
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.blueGrey)
          ),
        ),
      ),
    onPressed: () {
      pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  );
}

Widget SubmitButton(
  {required GlobalKey<FormState> key,
   required PageController pageController,
   required scaffoldContext}
  ){
  return ElevatedButton(
    child: Text('Submit', style: TextStyle(color: Colors.black),),
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.blueGrey)
        ),
      ),
    ),
    onPressed: () {
      if (key.currentState!.validate()) {
        key.currentState!.save();
        SnackBar snackBar = SnackBar(content: Text("Completed"));
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
      }
      else {
        SnackBar snackBar = SnackBar(
          content: Text("Complete all fields",
              style: TextStyle(color: Colors.yellowAccent)
          ),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(scaffoldContext).showSnackBar(snackBar);
      }
    },
  );
}