import 'dart:convert';

import 'package:get/get.dart';
import 'package:min_fitness/mock_data/body_parts.dart';
import 'package:min_fitness/models/bodyPart_model.dart';

class ExerciseController extends GetxController {
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  late List<BodyPartModel> _bodyPartList = [];
  List<BodyPartModel> get bodyPartList => _bodyPartList;

  @override
  onReady() async {
    super.onReady();
    _bodyPartList = await getBodyParts();
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
}
