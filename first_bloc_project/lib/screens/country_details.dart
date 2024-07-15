import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/data/models/countries.dart';
import '../business_logic/cubit/countries_cubit.dart';

class CountryDetailsScreen extends StatelessWidget {
  final Country country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("employee: ${country.employee_code}", style: TextStyle(color: Colors.yellow.shade100),),
      ),
      body: buildDetails()
    );
  }

  Widget buildDetails(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(2),
            width: double.infinity,
            height: 200,
            color: Color(0xFFe3a5f4),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(country.img), fit: BoxFit.cover),
            ),
            child: Text(
              "Name: ${country.name}\n"
              "Gender: ${country.gender}\n"
              "Business Unit: ${country.business_unit}\n"
              "Hierarchy: ${country.hierarchy}\n"
              "Email: ${country.email}\n"
              "Mobile Number: ${country.mobile_number}\n"
            ),
          ),
        ]
    );
  }
}
