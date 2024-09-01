import 'package:flutter/material.dart';
import 'package:interactive_form/data/models/question.dart';

class CheckBoxWidget extends StatefulWidget {
  final Question question;
  final List<String> options;

  const CheckBoxWidget({super.key, required this.question, required this.options});

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  final Map<String, bool> _checkedOptions = {};

  @override
  void initState() {
    super.initState();
    for (var option in widget.options) {
      _checkedOptions[option] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.question.isEnabled){
      return checkBoxForm();
    }
    else {
      return AbsorbPointer(
          absorbing: true,
          child: Opacity(
            opacity: 0.5,
            child: checkBoxForm(),
          )
      );
    }
  }

  Widget checkBoxForm(){
    return FormField<Map<String, bool>>(
      initialValue: _checkedOptions,
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
                  Checkbox(
                    value: _checkedOptions[option],
                    onChanged: (value) {
                      setState(() {
                        _checkedOptions[option] = value!;
                        field.didChange(_checkedOptions);
                      });
                    },
                  ),
                  Text(option),
                ],
              );
            }).toList(),
            SizedBox(height: 30)
          ],
        );
      },
      validator: (value) {
        if (widget.question.isMandatory && !_checkedOptions.containsValue(true)) {
          return 'Please choose value';
        }
      },
    );
  }
}
