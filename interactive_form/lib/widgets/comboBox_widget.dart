import 'package:flutter/material.dart';
import 'package:interactive_form/data/models/question.dart';

class ComboBoxWidget extends StatefulWidget {
  final Question question;
  final List<dynamic> dropDownList;

  const ComboBoxWidget({super.key, required this.question, required this.dropDownList});

  @override
  State<ComboBoxWidget> createState() => _ComboBoxWidgetState();
}

class _ComboBoxWidgetState extends State<ComboBoxWidget> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    if(widget.question.isEnabled){
      return comboBoxForm();
    }
    else {
      return AbsorbPointer(
          absorbing: true,
          child: Opacity(
            opacity: 0.5,
            child: comboBoxForm(),
          )
      );
    }
  }

  Widget comboBoxForm(){
    return FormField<String>(
      initialValue: _selectedValue,
      builder: (field){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.question.name,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            DropdownButtonFormField<String>(
              value: _selectedValue,
              items: widget.dropDownList.map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                  field.didChange(_selectedValue);
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              validator: (value) {
                if (widget.question.isMandatory && value == null) {
                  return 'Please select an option';
                }
                return null;
              }
            )
          ]
        );
      }
    );
  }
}
