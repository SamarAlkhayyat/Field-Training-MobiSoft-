part of 'countries_cubit.dart';

@immutable
abstract class CountriesState {
  @override
  List<Object?> get props => [];
}

class CountriesInitial extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final List<Country> countries;

  CountriesLoaded(this.countries);

  @override
  List<Object> get props => [countries];
}