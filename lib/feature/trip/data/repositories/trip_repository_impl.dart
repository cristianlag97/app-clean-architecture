import 'package:clean_code_app_riverpod_hive/core/errors/failure.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/data/datasources/trip_local_datasource.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/data/models/trip_model.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/domain/entities/trip.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/domain/repositories/trip_repository.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/domain/usecases/get_trips.dart';
import 'package:dartz/dartz.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDatasource localDatasource;

  const TripRepositoryImpl(this.localDatasource);

  @override
  Future<void> addTrips(Trip trip) async {
    final tripModel = TripModel.fromEntity(trip);
    await localDatasource.addTrips(tripModel);
  }

  @override
  Future<void> deleteTrips(int index) async {
    await localDatasource.deleteTrips(index);
  }

  @override
  Future<Either<Failure, List<Trip>>> getTrips() async {
    try {
      final tripsModel = localDatasource.getTrips();
      List<Trip> resp = tripsModel.map((trip) => trip.toEntity()).toList();
      return Right(resp);
    } catch (e) {
      return Left(SomeSpecificError(e.toString()));
    }
  }
}
