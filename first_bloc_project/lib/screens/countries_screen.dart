import 'package:flutter/material.dart';
import '../data/models/countries.dart';
import '../utilities/country_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/cubit/countries_cubit.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  List<Country> allCountries = []; //can use ? instead of late
  List<Country> searchedCountries = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState(){
    super.initState();
    BlocProvider.of<CountriesCubit>(context).getAllCountries(); //UI request of data
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: _isSearching ? buildSearchField() : Text("Countries", style: TextStyle(color: Colors.yellow.shade100)),
          leading: _isSearching ? BackButton(color: Colors.yellow.shade100, onPressed: _stopSearching) : Container(),
          actions: [
            if(_isSearching)
              IconButton(
                icon: Icon(Icons.clear, color: Colors.yellow.shade100),
                onPressed: () {
                  _clearSearch();
                  Navigator.pop(context);
                }
              )
            else
              IconButton(
                icon: Icon(Icons.search, color: Colors.yellow.shade100),
                onPressed: _startSearching
              )
          ],
        ),
        body: buildBlocWidget(),
      )
    );
  }

  Widget buildBlocWidget(){
    return BlocBuilder<CountriesCubit, CountriesState>(
        builder: (context, state) { //when context is not used, replace with _
          if (state is CountriesLoaded) {
            allCountries = (state).countries;
            return buildCountries();
          } else {
            return showLoadingIndicator();
          }
        }
    );
  }

  Widget showLoadingIndicator(){
    return Center(
      child: CircularProgressIndicator(
        color: Colors.black54,
      ),
    );
  }

  Widget buildCountries() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1.7,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.all(2),
        itemCount: _searchTextController.text.isEmpty ? allCountries.length : searchedCountries.length,
        itemBuilder: (context, index) {
          return CountryItem(country: _searchTextController.text.isEmpty ? allCountries[index] : searchedCountries[index]);
        }
    );
  }

  Widget buildSearchField(){
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.yellow.shade100,
      decoration: InputDecoration(
        hintText: "Find a country by code",
        hintStyle: TextStyle(color: Colors.yellow.shade100, fontSize: 16)
      ),
      style: TextStyle(color: Colors.black),
      onChanged: (searchedCountry) {
        searchedFromList(searchedCountry);
      },
    );
  }

  void _startSearching(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching(){
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });
  }

  void searchedFromList(String searchedCountry){
    searchedCountries = allCountries.where((item) => item.char_id.toLowerCase().startsWith(searchedCountry)).toList();
  }
}

