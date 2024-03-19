import 'package:clean_code_app_riverpod_hive/feature/trip/domain/repositories/trip_repository.dart';

import '../entities/trip.dart';

class AddTrips {
  final TripRepository repository;

  AddTrips(this.repository);

  Future<void> call(Trip trip) {
    return repository.addTrips(trip);
  }
}
