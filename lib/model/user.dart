
class User{
  final String name;
  final String? businessName;
  final String? businessRegistrationNumber;
  final String contact;
  final String location;
  final String? idNumber;
  final String? idType;
  final String momos;
  final String momosNumber;
  final String momosNetwork;
  final String? isAmbassador;
  final String? isLandTenureAgent;
  final String? zone;
  final String? region;
  final String latitude;
  final String longitude;


  User({
    required this.name,
    this.businessName,
    this.businessRegistrationNumber,
    required this.contact,
    required this.location,
    this.idNumber,
    this.idType,
    required this.momos,
    required this.momosNumber,
    required this.momosNetwork,
    this.isAmbassador,
    this.isLandTenureAgent,
    this.zone,
    this.region,
    required this.latitude,
    required this.longitude,
});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      businessName: json['businessName'],
      businessRegistrationNumber: json['businessRegistrationNumber'],
      contact: json['contact'],
      location: json['location'],
      idNumber: json['idNumber'],
      idType: json['idType'],
      momos: json['momos'],
      momosNumber: json['momosNumber'],
      momosNetwork: json['momosNetwork'],
      isAmbassador: json['isAmbassador'],
      isLandTenureAgent: json['isLandTenureAgent'],
      zone: json['zone'],
      region: json['region'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'businessName': businessName,
      'businessRegistrationNumber': businessRegistrationNumber,
      'contact': contact,
      'location': location,
      'idNumber': idNumber,
      'idType': idType,
      'momos': momos,
      'momosNumber': momosNumber,
      'momosNetwork': momosNetwork,
      'isAmbassador' : isAmbassador,
      'isLandTenureAgent' : isLandTenureAgent,
      'zone' : zone,
      'region' : region,
      'latitude' : latitude,
      'longitude' : longitude,
  
    };
  }
}