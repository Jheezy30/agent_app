
import 'package:agent_app/model/momo.dart';

class User {
  final String user_id;
  final String name;
  final String? business_name;
  final String? business_registration_number;
  final String contact;
  final String location;
  final String? id_number;
  final String? id_type;
  final List<Momo> momos;

  final bool? is_ambassador;
  final bool? is_land_tenure_agent;
  final String? zone;
  final String? region;
  final String? coordinates;
  final String latitude;
  final String longitude;

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
    return User(
      user_id: json['user_id'],
      name: json['name'],
      business_name: json['business_name'],
      business_registration_number: json['business_registration_number'],
      contact: json['contact'],
      location: json['location'],
      id_number: json['id_number'],
      id_type: json['id_type'],
      momos: json['momos'],
      is_ambassador: json['is_ambassador'],
      is_land_tenure_agent: json['is_land_tenure_agent'],
      zone: json['zone'],
      region: json['region'],
      coordinates: json['coordinates'],
      latitude: json['latitude'],
      longitude: json['longitude'],
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
    'momos': momos,
    'is_ambassador': is_ambassador,
    'is_land_tenure_agent': is_land_tenure_agent,
    'zone': zone,
    'region': region,
    'coordinates': coordinates,
    'latitude': latitude,
    longitude: longitude,
  };
}
