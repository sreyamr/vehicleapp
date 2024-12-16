class Transmission {
  final int? id;
  final String? name;

  Transmission({
    this.id,
    this.name,
  });

  factory Transmission.fromJson(Map<String, dynamic> json) {
    return Transmission(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}