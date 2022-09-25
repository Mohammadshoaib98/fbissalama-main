import 'package:fbissalama/Services/firestore_services.dart';
import 'package:fbissalama/models/Journey.dart';
import 'package:fbissalama/models/add_to_journey_model.dart';
import 'package:fbissalama/models/user_data.dart';
import '../utilities/api_path.dart';

abstract class Database {
  Stream<List<Journey>> salesProductsStream();
  Stream<List<Journey>> newJourneysStream();
  Stream<List<AddToJourneyModel>> myJourneysCart();
   Future<void> setUserData(UserData userData);
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreServices.instance;

  FirestoreDatabase(this.uid);

  @override
  Stream<List<Journey>> salesProductsStream() => _service.collectionsStream(
    path: ApiPath.journeys(),
    builder: (data, documentId) => Journey.fromMap(data!, documentId),
    queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
  );

  @override
  Stream<List<Journey>> newJourneysStream() => _service.collectionsStream(
    path: ApiPath.journeys(),
    builder: (data, documentId) => Journey.fromMap(data!, documentId),
  );

  @override
  Future<void> setUserData(UserData userData) async => await _service.setData(
    path: ApiPath.user(userData.uid),
    data: userData.toMap(),
  );
  
  
  @override
  Stream<List<AddToJourneyModel>> myJourneysCart() {
    // TODO: implement myJourneysCart
    throw UnimplementedError();
  }

  // @override
  // Future<void> addToJourney(Journey journey) async => _service.setData(
  //   path: ApiPath.addToJourneys(uid, journey,journeyId),
  //   data: journey.toMap(),
  // );
  
 
 
}
