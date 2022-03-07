import 'package:flutter/material.dart';

class Post with ChangeNotifier {
  String imageUrl;
  String name;
  double rate;
  String mapUrl;
  String comment;
  String placeName;

  Post({
    @required this.imageUrl,
    @required this.name,
    @required this.rate,
    @required this.mapUrl,
    @required this.comment,
    @required this.placeName,
  });
}
