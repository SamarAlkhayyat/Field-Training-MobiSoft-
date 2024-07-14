import 'package:flutter/material.dart';
import '../data/models/countries.dart';
import 'package:untitled/utilities/routes.dart';

class CountryItem extends StatelessWidget {
  final Country country;

  const CountryItem({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
              Navigator.pushNamed(context, AppRouter.countryDetailsScreen,
                  arguments: country)
            ,print("taped")},
      child:Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
      decoration: BoxDecoration(
          color: Color(0xFFe3a5f4),
          borderRadius: BorderRadius.circular(10)
      ),
      child: GridTile(
        child: Text("Employee: ${country.char_id}\n${country.name}\n", style: TextStyle(
          height: 1,
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        textAlign: TextAlign.center
        ),
        footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(country.job_title, style: TextStyle(
              height: 1,
              fontSize: 14,
              color: Colors.yellow.shade100,
              fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center
            ),
          ),
        ),
      )
    );
  }
}