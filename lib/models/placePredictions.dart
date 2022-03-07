class PlacePredictions {
  String mainText;
  String secondText;
  String placeId;

  PlacePredictions({this.mainText, this.secondText, this.placeId});

  PlacePredictions.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    secondText = json['structured_formatting']['secondary_text'];
    mainText = json['structured_formatting']['main_text'];
  }
}
