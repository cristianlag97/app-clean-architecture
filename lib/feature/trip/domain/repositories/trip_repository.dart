import 'package:clean_code_app_riverpod_hive/feature/trip/domain/entities/trip.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';

abstract class TripRepository {
  Future<Either<Failure, List<Trip>>> getTrips();
  Future<void> addTrips(Trip trip);
  Future<void> deleteTrips(int index);
}
