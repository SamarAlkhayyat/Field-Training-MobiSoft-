import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/data/models/countries.dart';
import 'package:untitled/screens/countries_screen.dart';
import '../data/repositories/countries_repository.dart';
import '../data/web_services/countries_web_services.dart';
import 'package:untitled/screens/country_details.dart';
import 'package:untitled/business_logic/cubit/countries_cubit.dart';

  class AppRouter {
    static const String countriesScreen = "/";
    static const String countryDetailsScreen = "/country_details";
    late CountriesRepository countriesRepository;
    late CountriesCubit countriesCubit;

    AppRouter(){
      countriesRepository = CountriesRepository(CountriesWebServices());
      countriesCubit = CountriesCubit(countriesRepository);
    }

  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case countriesScreen: //var holding '/' as value
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => countriesCubit,
            child: CountriesScreen()
          )
        );
      case countryDetailsScreen:
        final country = settings.arguments as Country;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => countriesCubit,
            child: CountryDetailsScreen(country: country,)
          )
        );
    }
  }
}