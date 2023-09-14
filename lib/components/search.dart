import 'package:flutter/material.dart';
import 'package:weather/api.dart';
import 'package:weather/models/city_model.dart';

class CitySearchDelegate extends SearchDelegate<City?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [const SizedBox.shrink()];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsWidgets();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResultsWidgets();
  }

  Widget buildResultsWidgets() {
    if (query.isEmpty) {
      return const Align(
          alignment: Alignment.topCenter, child: Text('Enter a city name'));
    }
    return FutureBuilder<List<City>>(
      future: fetchCitiesByQuery(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No results found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].fullName),
                onTap: () {
                  close(context, snapshot.data![index]);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Align(
              alignment: Alignment.topCenter,
              child: Text('Something went wrong. Please try again later'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
