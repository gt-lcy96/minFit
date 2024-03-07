import 'package:flutter/material.dart';


class WorkoutDetail extends StatelessWidget {
  WorkoutDetail({super.key, this.id});
  final id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Workout Detail: ${id}'),
        ),
      ),
    );
  }
}