class SearchedPlaces {
  SearchedPlaces(
      {required this.address,
      required this.hours,
      required this.name,
        required this.imageUrl,
        required this.ratings,
        required this.phoneNumber,
        required this.documentName,
        this.tripDocId,
      required this.reviews,
      required this.latitude,
      required this.longitude
      });
  String name;
  String address;
  String documentName;
  String phoneNumber;
  String imageUrl;
  String? tripDocId; 
  String hours;
  double ratings;
  String reviews;
  double latitude;
  double longitude;
  static SearchedPlaces fromMap(Map<String, dynamic> data) => SearchedPlaces(
        address: data["address"],
        tripDocId: data["tripDocId"],
        hours: data["hours"],
        name: data["name"],
        imageUrl: data["imageUrl"],
        documentName: data["documentName"],
        ratings: data["ratings"],
        reviews: data["reviews"],
        phoneNumber: data["phoneNumber"],
        latitude: data["latitude"],
        longitude: data["longitude"]
        
      );

 toMap() =>{
  "name":name,
  "phoneNumber":phoneNumber,
  "address":address,
  "imageUrl":imageUrl,
  "hours":hours,
  "reviews":reviews,
  "ratings":ratings,
  "documentName":documentName,
  "tripDocId":tripDocId,
  "longitude":longitude,
  "latitude":latitude
 };
}
