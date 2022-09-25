class Journey {
  final String agencyId;
  final String journeyId;
  final String sourceCity;
  final String distintionCity;
  final String agencyName;
  final String journeyDate;
  final String journeyTime;
  final int price;
  final int? rate;

  Journey({required this.agencyId, required this.journeyId, required this.sourceCity, required this.distintionCity, required this.agencyName, required this.journeyDate, required this.journeyTime, required this.price, this.rate});

  Map<String, dynamic> toMap() {
    return {
      'agencyId': agencyId,
      'journeyId': journeyId,
      'sourceCity': sourceCity,
      'distintionCity': distintionCity,
      'agencyName': agencyName,
      'journeyDate': journeyDate,
      'journeyTime': journeyTime,
      'price': price,
      'rate': rate,
    };
  }

  factory Journey.fromMap(Map<String, dynamic> map, String documentId) {
    return Journey(
      agencyId: map['agencyId'] as String,
      journeyId: map['journeyId'] as String,
      sourceCity: map['sourceCity'] as String,
      distintionCity: map['distintionCity'] as String,
      agencyName: map['agencyName'] as String,
      journeyDate: map['journeyDate'] as String,
      journeyTime: map['journeyTime'] as String,
      price: map['price'] as int,
      rate: map['rate'] as int,
    );
  }
}
