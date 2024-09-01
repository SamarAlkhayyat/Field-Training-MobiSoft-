import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interactive_form/data/models/question.dart';

class RadioWidget<T> extends StatefulWidget {
  final Question question;
  final List<T> options;

  const RadioWidget({required this.question, Key? key, required this.options}) : super(key: key);

  @override
  State<RadioWidget<T>> createState() => _RadioWidgetState<T>();
}

class _RadioWidgetState<T> extends State<RadioWidget<T>> {
  T? _radioValue;

  @override
  Widget build(BuildContext context) {
    if(widget.question.isEnabled){
      return radioForm();
    }
    else {
      return AbsorbPointer(
          absorbing: true,
          child: Opacity(
            opacity: 0.5,
            child: radioForm(),
          )
      );
    }
  }

  Widget radioForm(){
    return FormField<T>(
      initialValue: _radioValue,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.question.name,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            ...widget.options.map((option) {
              return Row(
                children: [
                  Radio<T>(
                    value: option,
                    groupValue: _radioValue,
                    onChanged: (value) {
                      setState(() {
                        _radioValue = value;
                        field.didChange(option);
                      });
                    },
                  ),
                  Text(optionDisplay(option)),
                ],
              );
            }).toList(),
          ],
        );
      },
      validator: (value) {
        if (widget.question.isMandatory && value == null) {
          return 'Please choose value';
        }
      },
    );
  }

  String optionDisplay(T option) {
    if (option is bool) {
      return option ? 'True' : 'False';
    } else if (option is Enum) {
      return option.toString().split('.').last;
    } else {
      return option.toString();
    }
  }
}
