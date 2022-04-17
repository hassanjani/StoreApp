import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:user_app/provider/auth_provider.dart';
import 'package:user_app/view/screen/auth/widget/places/Suggestion.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        //   close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Suggestion>>(
      // We will put the api call here
      future: PlaceApiProvider().fetchSuggestions(query, "en"),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: context.watch<AuthProvider>().SelectedArea == ""
                  ? Text('Enter your address')
                  : Text('${context.watch<AuthProvider>().SelectedArea}'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    // we will display the data returned from our future here
                    title: Text(snapshot.data[index].description),
                    onTap: () async {
                      Provider.of<AuthProvider>(context, listen: false)
                          .onchangeArea(snapshot.data[index].description);
                      LatLng latLng = await PlaceApiProvider()
                          .getPlaceDetailFromId(snapshot.data[index].placeId);
                      print(latLng.latitude);
                      print(latLng.longitude);
                      await Provider.of<AuthProvider>(context, listen: false)
                          .onchangeAreaLatlng(latLng);
                      close(context, snapshot.data[index]);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}
