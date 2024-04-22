
class Momo {
  final String number;
  final String network;
   

  Momo({required this.number, required this.network});

   factory Momo.fromJson(Map<String, dynamic> json) {
    return Momo(
      number: json['number'],
      network: json['network'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'network': network,
    };
  }
}
