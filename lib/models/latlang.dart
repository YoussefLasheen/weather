class LatLng {
  final double latitude;
  final double longitude;

  LatLng({required this.latitude, required this.longitude});


  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(
      latitude: json['lat'],
      longitude: json['lon'],
    );
  }
  //to convert the object to json
  Map<String, dynamic> toJson() {
    return {
      'lat': latitude,
      'lon': longitude,
    };
  }
}