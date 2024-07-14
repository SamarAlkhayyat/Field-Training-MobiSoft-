import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/countries.dart';
import '../../data/repositories/countries_repository.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CountriesRepository countriesRepository;
  List<Country> countries = [];

  CountriesCubit(this.countriesRepository) : super(CountriesInitial());

  List<Country> getAllCountries() {
    countriesRepository.getAllCountries().then((countries) {
      emit(CountriesLoaded(countries));
      this.countries = countries;
    });
    return countries;
  }
}
