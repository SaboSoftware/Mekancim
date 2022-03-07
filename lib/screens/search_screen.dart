import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mekancimapp/helpers/requestAssistants.dart';
import 'package:mekancimapp/models/place.dart';
import 'package:mekancimapp/models/placePredictions.dart';
import 'package:mekancimapp/providers/location.helper.dart';
import 'package:mekancimapp/screens/post_add_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController placeTextEditingController =
      new TextEditingController();
  List<PlacePredictions> placePredictonList = [];
  String selectedPlaceId;

  void findPlace(String placeName) async {
    LatLng currentLocation = await LocationHelper.getCurrentLocation();

    double lat = currentLocation.latitude;

    double lng = currentLocation.longitude;

    if (placeName.length > 1) {
      String autoCompleteUrl =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&location=$lat%2C$lng&radius=50 &key=$GOOGLE_API_KEY';

      var res = await LocationHelper.getRequest(autoCompleteUrl);

      if (res == 'failed') {
        return;
      }
      if (res['status'] == 'OK') {
        var predictions = res['predictions'];

        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        setState(() {
          placePredictonList = placesList;
        });
      } else {}

      print('Places Prediction Response');
      print(res);
      print(autoCompleteUrl);
    }
  }

  void getPlaceAddressDetails(String placeId) async {
    String placeDetailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?&place_id=$placeId&key=$GOOGLE_API_KEY';

    var res = await RequestAssistant.getRequest(placeDetailsUrl);

    if (res == 'failed') {
      return;
    }
    if (res['status'] == 'OK') {
      double lat = res['result']['geometry']['location']['lat'];
      double lng = res['result']['geometry']['location']['lng'];

      // Address address = new Address();
      // address.placeName = res['result']['name'];
      // address.placeId = placeId;
      // address.latitude = res['result']['geometry']['location']['lat'];
      // address.longitude = res['result']['geometry']['location']['lng'];
      // final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      //   latitude: address.latitude,
      //   longitude: address.longitude,
      // );
      LatLng selectedPlace = LatLng(lat, lng);
      setState(() {
        selectedPlaceId = placeId;
      });
      // print('map url $staticMapImageUrl');
      // print('address lat ${address.latitude}');
      // print('address lng ${address.longitude}');
      print('double lat $lat');
      print('double lng $lng');
      print(placeId);
      Navigator.of(context).pop(selectedPlaceId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.only(left: 10),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          title: Text(
            'Mekan Ara',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          child: Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: TextField(
                                onChanged: (val) {
                                  findPlace(val);
                                },
                                controller: placeTextEditingController,
                                decoration: InputDecoration(
                                  hintText: 'Mekan Ara!',
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 11, top: 8, bottom: 8),
                                ),
                              ),
                            ),
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            (placePredictonList.length > 0)
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: placePredictonList.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemBuilder: (ctx, i) {
                        return predictionTile(
                          placePredictonList[i],
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ));
  }

  Widget predictionTile(PlacePredictions placePredictions) {
    return InkWell(
      onTap: () {
        getPlaceAddressDetails(placePredictions.placeId);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(placePredictions.mainText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 3,
                      ),
                      placePredictions.secondText == null
                          ? Container()
                          : Text(placePredictions.secondText,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
