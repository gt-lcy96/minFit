import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:min_fitness/helper/pretty_print.dart';
import 'package:min_fitness/mock_data/body_parts.dart';
import 'package:min_fitness/models/bodyPart_model.dart';
import 'package:min_fitness/models/exercise_model.dart';
import 'package:min_fitness/repositories/exercise_repo.dart';

class ExerciseController extends GetxController {
  final ExerciseRepo exerciseRepo;
  ExerciseController({required this.exerciseRepo});

  int _slider_index = 0;
  int get slider_index => _slider_index;

  late String _selected_equipment;
  String get selected_equipment => _selected_equipment;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _equipmentIsSelected = false;
  bool get equipmentIsSelected => _equipmentIsSelected;

  late List<BodyPartModel> _bodyPartList = [];
  List<BodyPartModel> get bodyPartList => _bodyPartList;

  late List<ExerciseModel>? _exerciseList = [];
  List<ExerciseModel>? get exerciseList => _exerciseList;

  late List<ExerciseModel>? _exerciseDisplayList = [];
  List<ExerciseModel>? get exerciseDisplayList => _exerciseDisplayList;

  @override
  onReady() async {
    super.onReady();
    _bodyPartList = await getBodyParts();
    _exerciseList = await getExerciseList();
    await searchExerciseDisplayList('chest');
    // _selected_equipment = _exerciseDisplayList![0].equipment;
    _isLoaded = true;
    update();
    print("_isLoaded:  ${_isLoaded}");
  }

  Future<void> searchExerciseDisplayList(String keyword) async {
    _isLoaded = false;
    _equipmentIsSelected = false;
    update();
    Response response = await exerciseRepo.searchExerciseDisplayList(keyword);

    prettyPrintJson(response.body, prefix: 'response.body');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      // as List;
      final exerciseList =
          jsonResponse.map((e) => ExerciseModel.fromMap(e)).toList();
      _exerciseDisplayList = exerciseList as List<ExerciseModel>;
      setSelectedEquipment(_exerciseDisplayList![0].equipment);
      _isLoaded = true;
      update();
    } else {
      final jsonResponse =
          response.body is String ? json.decode(response.body) : response.body;
      if (kDebugMode) {
        print(jsonResponse['error']);
      }
    }
  }

  void setSliderIndex(int index) {
    _equipmentIsSelected = false;
    _isLoaded = false;

    _slider_index = index;
    _exerciseDisplayList = _exerciseList!
        .where(
            (ExerciseModel e) => e.bodyPart == bodyPartList[_slider_index].name)
        .toList();
    setSelectedEquipment(_exerciseDisplayList![0].equipment);

    _isLoaded = true;
    update();
  }

  void setSelectedEquipment(String value) {
    _selected_equipment = value;
    _equipmentIsSelected = true;
    update();
  }

  // ignore: non_constant_identifier_names
  Future<List<BodyPartModel>> getBodyParts() async {
    _isLoaded = false;
    await Future.delayed(Duration(seconds: 1));
    return BodyPart()
        .bodyPartList
        .map((e) => BodyPartModel.fromJson(json.encode(e)))
        .toList();
  }

  Future<List<ExerciseModel>> getExerciseList() async {
    try {
      Response response = await exerciseRepo.getExerciseList();
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.body is String
            ? json.decode(response.body) as List
            : response.body;

        final exerciseList = jsonResponse.map((e) {
          // print("e.runtimeType:  ${e.runtimeType}");
          return ExerciseModel.fromMap(e as Map<String, dynamic>);
        }).toList();

        print("exerciseList.runtimeType:  ${exerciseList.runtimeType}");
        return exerciseList;
      } else {
        if (kDebugMode) {
          print('Failed to getExerciseList from server');
        }
        return [];
      }
    } catch (e) {
      print('Exeption occurs: ${e}');
      return [];
    }
  }
}
