import 'package:clean_code_app_riverpod_hive/feature/trip/domain/entities/trip.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/domain/repositories/trip_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

class GetTrips {
  final TripRepository repository;

  GetTrips(this.repository);

  Future<Either<Failure, List<Trip>>> call() {
    return repository.getTrips();
  }
}

class SomeSpecificError extends Failure {
  SomeSpecificError(super.message);
  // SomeSpecificError(String message) : super(message);
}
