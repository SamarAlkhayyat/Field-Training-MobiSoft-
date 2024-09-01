import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/models/question.dart';

class TextWidget extends StatefulWidget {
  final Question question;

  const TextWidget({super.key, required this.question});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _textEditingController,
          decoration: InputDecoration(
            label: Text(widget.question.name,
              style: TextStyle(color: widget.question.isEnabled? Colors.black : Colors.grey, fontSize: 16),
            ),
          ),
          enabled: widget.question.isEnabled? true : false,
          keyboardType: widget.question.numericalKeyboardType ? TextInputType.number : TextInputType.text,
          inputFormatters: widget.question.numericalKeyboardType? [FilteringTextInputFormatter.digitsOnly] : [],
          validator: widget.question.isMandatory? (value) {
            if(value!.isEmpty)
              return 'Please enter value';
          }
          : (value){},
        ),
        SizedBox(height: 30)
      ],
    );
  }
}
