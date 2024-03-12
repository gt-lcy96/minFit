import 'package:get/get.dart';
import 'package:min_fitness/mock_data/weight_with_date.dart';
import 'package:min_fitness/models/weight_model.dart';

class WeightController extends GetxController {
  DateTime _created_at = DateTime.parse('2024-03-03 00:00:00.000');
  DateTime get created_at => _created_at;


  double _weight = 75;
  double get weight => _weight;

  List<WeightModel> _weight_with_date =
      WeightOnDate.weightDate.map((e) => WeightModel.fromMap(e)).toList();
  List<WeightModel> get weight_with_date => _weight_with_date;

  void setCreatedAt(DateTime datetime) {
    _created_at = datetime;
    update();
  }

  void sortByDate() {
    weight_with_date.sort((a, b) => a.date.compareTo(b.date));
    update();
    print("weight_with_date:  ${weight_with_date}");
  }

  bool updateWeightWithSameDate(WeightModel inputModel) {
    bool dateExisted = false;
    for (var model in _weight_with_date) {
      if (model.date == inputModel.date) {
        model.weight = inputModel.weight;
        dateExisted = true;
        break; // Stop the loop once we've found and updated the right date
      }
    }

    return dateExisted;
  }

  double parseDouble(String value, {double defaultValue = 0.0}) {
  double? result = double.tryParse(value);

  return result ?? defaultValue;
}

  void setWeight(String weight) {
    _weight = parseDouble(weight);
    update();
  }

  void submitWeight(WeightModel inputModel) {
    bool dateExisted = updateWeightWithSameDate(inputModel);
    if(dateExisted == false) {
      weight_with_date.add(WeightModel(weight: _weight, date: created_at));
    }
    update();
  }
}
