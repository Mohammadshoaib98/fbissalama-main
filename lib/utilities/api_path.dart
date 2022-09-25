import 'package:fbissalama/models/Journey.dart';

class ApiPath {
  static String journeys() => 'journeys/';
  static String user(String uid) => 'users/$uid';
  static String addToJourneys(String uid, Journey journey,String journeyId) => 'agencies/journeys/$uid/$journeyId/$journey';
  static String myJourneys(String uid) => 'users/$uid/cart/';
}