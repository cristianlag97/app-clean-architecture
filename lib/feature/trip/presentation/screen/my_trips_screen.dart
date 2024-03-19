import 'package:clean_code_app_riverpod_hive/feature/trip/presentation/providers/trip_provider.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/presentation/widgets/travel_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../widgets/custom_search_bar.dart';

class MyTripsScreen extends ConsumerWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripList = ref.watch(tripListNotifierProvider);

    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: <Widget>[
          CustomSearchBar(),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tripList.length,
            itemBuilder: (context, index) {
              final trip = tripList[index];
              return TravelCard(
                imageUrl: trip.photos[0],
                title: trip.title,
                description: trip.description,
                date: DateFormat.yMMMEd().format(trip.date).toString(),
                location: trip.location,
                onDelete: () {
                  ref.read(tripListNotifierProvider.notifier).removeTrip(index);
                  ref.read(tripListNotifierProvider.notifier).loadTrip();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
