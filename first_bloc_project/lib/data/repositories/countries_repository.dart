import 'package:untitled/data/web_services/countries_web_services.dart';
import '../models/countries.dart';

class CountriesRepository {
  final CountriesWebServices countriesWebServices;

  CountriesRepository(this.countriesWebServices);

  Future<List<Country>> getAllCountries() async{
    final countries = await countriesWebServices.getAllCountries();
    return countries.map((country) => Country.fromJson(country)).toList();
  }
}