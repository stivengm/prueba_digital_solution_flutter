import 'package:flutter/material.dart';

class SearchMarkerDelegate extends SearchDelegate {

  SearchMarkerDelegate():super(
    searchFieldLabel: 'Buscar...'
  );
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear
        ),
        onPressed: () => query = ''
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_rounded
      ),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: const Text("Calle 138C sur 14k 26"),
          onTap: () {},
        )
      ],
    );
  }

}