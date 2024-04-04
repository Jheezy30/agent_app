
class User{
  final String name;
  final String? businessName;
  final String? businessRegistration;
  final String phone;
  final String? idNumber;
  final String idType;
  final String selectedValue;
  final String selected;
  final String wallet;

  User({
    required this.name,
    this.businessName,
    this.businessRegistration,
    required this.phone,
    this.idNumber,
    required this.idType,
    required this.selectedValue,
    required this.selected,
    required this.wallet,
});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      businessName: json['businessName'],
      businessRegistration: json['businessRegistration'],
      phone: json['phone'],
      idNumber: json['idNumber'],
      idType: json['idType'],
      selectedValue: json['selectedValue'],
      selected: json['selected'],
      wallet: json['wallet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'businessName': businessName,
      'businessRegistration': businessRegistration,
      'phone': phone,
      'idNumber': idNumber,
      'idType': idType,
      'selectedValue': selectedValue,
      'selected': selected,
      'wallet': wallet,
    };
  }
}