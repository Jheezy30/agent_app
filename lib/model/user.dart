import 'momo.dart';

class User {
  final String user_id;
  final String name;
  final String? business_name;
  final String? business_registration_number;
  final String contact;
  String location;
  final String? id_number;
  final String? id_type;
  final List<Momo> momos;
  final bool? is_ambassador;
  final bool? is_land_tenure_agent;
  final String? zone;
  String? region;
  final String? coordinates;
  String latitude;
  String longitude;

  User({
    required this.user_id,
    required this.name,
    this.business_name,
    this.business_registration_number,
    required this.contact,
    required this.location,
    this.id_number,
    this.id_type,
    required this.momos,
    this.is_ambassador,
    this.is_land_tenure_agent,
    this.zone,
    this.region,
    this.coordinates,
    required this.latitude,
    required this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var momosJson = json['momos'] as List<dynamic>? ?? [];
    List<Momo> momos = momosJson.map((momoJson) => Momo.fromJson(momoJson)).toList();

    return User(
      user_id: json['id'] ?? '', // Ensure non-null
      name: json['name'] ?? '', // Ensure non-null
      business_name: json['business_name'], // Can be null
      business_registration_number: json['business_registration_number'], // Can be null
      contact: json['contact'] ?? '', // Ensure non-null
      location: json['location'] ?? '', // Ensure non-null
      id_number: json['id_number'], // Can be null
      id_type: json['id_type'], // Can be null
      momos: momos,
      is_ambassador: json['is_ambassador'], // Can be null
      is_land_tenure_agent: json['is_land_tenure_agent'], // Can be null
      zone: json['zone'], // Can be null
      region: json['region'], // Can be null
      coordinates: json['coordinates'], // Can be null
      latitude: json['latitude'] ?? '', // Ensure non-null
      longitude: json['longitude'] ?? '', // Ensure non-null
    );
  }

  Map<String, dynamic> toJson() => {
    'user_id': user_id,
    'name': name,
    'business_name': business_name,
    'business_registration_number': business_registration_number,
    'contact': contact,
    'location': location,
    'id_number': id_number,
    'id_type': id_type,
    'momos': momos.map((momo) => momo.toJson()).toList(),
    'is_ambassador': is_ambassador,
    'is_land_tenure_agent': is_land_tenure_agent,
    'zone': zone,
    'region': region,
    'coordinates': coordinates,
    'latitude': latitude,
    'longitude': longitude,
  };
}
