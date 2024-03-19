import 'package:clean_code_app_riverpod_hive/feature/trip/data/datasources/trip_local_datasource.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/data/models/trip_model.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/data/repositories/trip_repository_impl.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/domain/repositories/trip_repository.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/domain/usecases/add_trips.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/domain/usecases/delete_trips.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/domain/usecases/get_trips.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/trip.dart';

final tripLocalDatasourceProvider = Provider<TripLocalDatasource>((ref) {
  final Box<TripModel> tripBox = Hive.box('trips');
  return TripLocalDatasource(tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDatasource = ref.read(tripLocalDatasourceProvider);
  return TripRepositoryImpl(localDatasource);
});

final addTripProvider = Provider<AddTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return AddTrips(repository);
});

final getTripsProvider = Provider<GetTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return GetTrips(repository);
});

final deleteTripProvider = Provider<DeleteTrips>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrips(repository);
});

final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<Trip>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrips = ref.read(addTripProvider);
  final deleteTrips = ref.read(deleteTripProvider);

  return TripListNotifier(getTrips, addTrips, deleteTrips);
});

class TripListNotifier extends StateNotifier<List<Trip>> {
  final GetTrips _getTrips;
  final AddTrips _addTrips;
  final DeleteTrips _deleteTrips;
  TripListNotifier(
    this._getTrips,
    this._addTrips,
    this._deleteTrips,
  ) : super([]);

  Future<void> addNewTrip(Trip trip) async {
    await _addTrips(trip);
  }

  Future<void> removeTrip(int tripId) async {
    await _deleteTrips(tripId);
  }

  Future<void> loadTrip() async {
    final tripsOrFailure = await _getTrips();
    tripsOrFailure.fold((error) => state = [], (trips) => state = trips);
  }
}
