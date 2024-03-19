import 'package:clean_code_app_riverpod_hive/feature/trip/domain/repositories/trip_repository.dart';

class DeleteTrips {
  final TripRepository repository;

  DeleteTrips(this.repository);

  Future<void> call(int index) {
    return repository.deleteTrips(index);
  }
}
