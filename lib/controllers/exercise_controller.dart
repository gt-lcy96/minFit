import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:min_fitness/mock_data/body_parts.dart';
import 'package:min_fitness/models/bodyPart_model.dart';
import 'package:min_fitness/models/exercise_model.dart';
import 'package:min_fitness/repositories/exercise_repo.dart';

class ExerciseController extends GetxController {

  final ExerciseRepo exerciseRepo;
  ExerciseController({required this.exerciseRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  late List<BodyPartModel> _bodyPartList = [];
  List<BodyPartModel> get bodyPartList => _bodyPartList;

  late List<ExerciseModel>? _exerciseList = [];
  List<ExerciseModel>? get exerciseList => _exerciseList;

  @override
  onReady() async {
    super.onReady();
    _bodyPartList = await getBodyParts();
    _exerciseList = await getExerciseList();
    _isLoaded = true;
    update();
    print("_isLoaded:  ${_isLoaded}");

  }

  // ignore: non_constant_identifier_names
  Future<List<BodyPartModel>> getBodyParts() async {
    _isLoaded = false;
    await Future.delayed(Duration(seconds: 1));
    return BodyPart().bodyPartList.map((e) => BodyPartModel.fromJson(json.encode(e))).toList();
  }

  Future<List<ExerciseModel>?> getExerciseList() async {
    try {

      Response response = await exerciseRepo.getExerciseList();
      if(response.statusCode == 200) {
        return response.body;
      } else {
        if(kDebugMode) {
          print('Failed to getExerciseList from server');
        }
        return [];
      }
    } catch (e) {
        print('Exeption occurs: ${e}');
    }
  }
}
