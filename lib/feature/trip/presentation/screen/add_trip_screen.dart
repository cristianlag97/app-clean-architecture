import 'package:clean_code_app_riverpod_hive/feature/trip/domain/entities/trip.dart';
import 'package:clean_code_app_riverpod_hive/feature/trip/presentation/providers/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class AddTripScreen extends ConsumerWidget {
  AddTripScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: 'City 1');
  final _descController = TextEditingController(text: 'Best city ever');
  final _locationController = TextEditingController(text: 'Rome');
  final _pictureController = TextEditingController(
      text:
          'https://media.istockphoto.com/id/539115110/es/foto/colosseum-in-rome-italy-y-sol-de-la-ma%C3%B1ana.jpg?s=612x612&w=0&k=20&c=S2BE7bvASd4hm6Yp0VbtvaGnnqTR4p5HJ-6RfDjR-MQ=');

  List<String> pictures = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextFormField(
            controller: _locationController,
            decoration: const InputDecoration(labelText: 'Location'),
          ),
          TextFormField(
            controller: _pictureController,
            decoration: const InputDecoration(labelText: 'Photo'),
          ),
          ElevatedButton(
              onPressed: () {
                pictures.add(_pictureController.text);
                if (_formKey.currentState!.validate()) {
                  final newTrip = Trip(
                    title: _titleController.text,
                    photos: pictures,
                    description: _descController.text,
                    date: DateTime.now(),
                    location: _locationController.text,
                  );

                  ref
                      .read(tripListNotifierProvider.notifier)
                      .addNewTrip(newTrip);
                  ref.read(tripListNotifierProvider.notifier).loadTrip();
                }
              },
              child: const Text('Add trip'))
        ],
      ),
    );
  }
}
