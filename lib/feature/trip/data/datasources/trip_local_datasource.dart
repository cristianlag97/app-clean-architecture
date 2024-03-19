import 'package:hive_flutter/hive_flutter.dart';

import '../models/trip_model.dart';

class TripLocalDatasource {
  final Box<TripModel> tripBox;

  TripLocalDatasource(this.tripBox);

  List<TripModel> getTrips() {
    return tripBox.values.toList();
  }

  addTrips(TripModel trip) {
    tripBox.add(trip);
  }

  deleteTrips(int index) {
    tripBox.delete(index);
  }
}
