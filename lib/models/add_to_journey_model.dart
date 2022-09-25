class AddToJourneyModel {
  final String agencyId;
  final String journeyId;
  final String sourceCity;
  final int destinationCity;
  final int journeyTime;
  final String journeyDate;
  final int price;

  AddToJourneyModel({
    required this.agencyId, required this.journeyId, required this.sourceCity, required this.destinationCity, required this.journeyTime, required this.journeyDate, required this.price
  });

  Map<String, dynamic> toMap() {
    return {
      'agencyId': agencyId,
      'journeyId': journeyId,
      'sourceCity': sourceCity,
      'destinationCity': destinationCity,
      'journeyTime': journeyTime,
      'journeyDate': journeyDate,
      'price': price,
    };
  }

  factory AddToJourneyModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AddToJourneyModel(
      agencyId: documentId,
      journeyId: map['journeyId'] as String,
      sourceCity: map['sourceCity'] as String,
      destinationCity: map['destinationCity'] as int,
      journeyTime: map['journeyTime'] as int,
      journeyDate: map['journeyDate'] as String,
      price: map['price'] as int,
    );
  }

}
