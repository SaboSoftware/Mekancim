import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mekancimapp/data/data.dart';
import 'package:mekancimapp/models/post.dart';
import 'package:mekancimapp/providers/location.helper.dart';
import 'package:mekancimapp/screens/maps_screen.dart';
import 'package:mekancimapp/screens/search_screen.dart';
//import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:provider/provider.dart';

class PostAddScreen extends StatefulWidget {
  @override
  _PostAddScreenState createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  TextEditingController mycontroller = new TextEditingController();
  TextEditingController yorum = new TextEditingController();
  // String placeId;
  double rating;
  LatLng _pickedLocation;
  String _previewImageUrl;
  var _newPost = Post(
    imageUrl:
        'https://cdn.armut.com/UserPics/tr:w-325,h-325/9c2c7e5c-1ff5-404e-88d4-cbc932602d9b.jpeg',
    name: 'Hüseyin Ablay',
    rate: 1,
    mapUrl: '',
    comment: '',
    placeName: '',
  );
  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      print(locData.latitude);
      print(locData.longitude);
      final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude,
        longitude: locData.longitude,
      );
      setState(() {
        _previewImageUrl = staticMapImageUrl;
        _newPost.mapUrl = _previewImageUrl;
      });
      _selectPlace(locData.latitude, locData.longitude);
      print(_previewImageUrl);
    } catch (error) {
      return;
    }
  }

  Future<void> searchPlace() async {
    final String placeId = await Navigator.of(context)
        .push<String>(MaterialPageRoute(builder: (ctx) => SearchScreen()));
    // print(selectedPlace.latitude);
    // print(selectedPlace.longitude);
    // _pickedLocation = LatLng(selectedPlace.latitude, selectedPlace.longitude);
    print('post add screen $placeId');
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: _pickedLocation.latitude,
      longitude: _pickedLocation.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _newPost.mapUrl = _previewImageUrl;
    });
    print(_previewImageUrl);
  }

  Future<void> _selectOnMap() async {
    final currentLocation = await LocationHelper.getCurrentLocation();
    print(currentLocation);
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          initialLocation: currentLocation,
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    print(selectedLocation);
    _pickedLocation =
        LatLng(selectedLocation.latitude, selectedLocation.longitude);

    final address = await LocationHelper.getPlaceAddress(
        _pickedLocation.latitude, _pickedLocation.longitude);
    print(address);
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: _pickedLocation.latitude,
      longitude: _pickedLocation.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _newPost.mapUrl = _previewImageUrl;
    });
    print(_previewImageUrl);
    print(_pickedLocation.latitude);
    print(_pickedLocation.longitude);
    final placeName = await LocationHelper.getPlaceName(
        _pickedLocation.latitude, _pickedLocation.longitude, 'Bim');
    print(placeName);
    setState(() {
      _newPost.placeName = placeName;
    });
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = LatLng(lat, lng);
  }

  // void _savePlace() {
  //   Provider.of<GreatPlaces>(context, listen: false)
  //       .addPlace('sa', _pickedLocation);
  //   // Navigator.of(context).pop();
  //   print(_pickedLocation.address);
  // }

  void saveFrom() {
    Provider.of<Data>(context, listen: false).addPost(_newPost);
    Navigator.of(context).pushReplacementNamed('/anasayfa');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarTheme.of(context).backgroundColor,
        elevation: 0.5,
        title: Text(
          "Gönderi Paylaş",
          style: TextStyle(fontFamily: 'Cocon', color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.blue,
            ),
            onPressed: saveFrom,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                highlightColor: Colors.white,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => SearchScreen()));
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: Colors.blue),
                      ),
                      child: _previewImageUrl == null
                          ? Text(
                              'Konumunu Seç',
                              textAlign: TextAlign.center,
                            )
                          : Image.network(
                              _previewImageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton.icon(
                          icon: Icon(
                            Icons.location_on,
                          ),
                          label: Text('Geçerli Konum'),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: _getCurrentUserLocation,
                        ),
                        FlatButton.icon(
                          icon: Icon(
                            Icons.map,
                          ),
                          label: Text('Haritadan Seç'),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: _selectOnMap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                        right: Radius.circular(10),
                      ),
                      color: Colors.blue,
                    ),
                    child: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {
                        setState(() {
                          _newPost.rate = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Deneyimini Oyla!',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Cocon'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://cdn.armut.com/UserPics/tr:w-325,h-325/9c2c7e5c-1ff5-404e-88d4-cbc932602d9b.jpeg',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      // controller: mycontroller,
                      maxLength: 300,

                      // ignore: deprecated_member_use
                      maxLengthEnforced: true,

                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) return "Lütfen yazı giriniz.";
                      },
                      decoration: InputDecoration(
                        labelText: "Günün Nasıl Geçti ?",
                      ),
                      maxLines: 2,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        setState(() {
                          _newPost.comment = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    height: 45,
                    width: 80,
                    child: IconButton(
                      icon: Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    height: 45,
                    width: 80,
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: saveFrom,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
