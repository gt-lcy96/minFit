import 'package:get/get.dart';
import 'package:min_fitness/mock_data/weight_with_date.dart';
import 'package:min_fitness/models/weight_model.dart';

class WeightController extends GetxController {
  DateTime _created_at = DateTime.parse('2024-03-03 00:00:00.000');
  DateTime get created_at => _created_at;

  double _weight = 75;
  double get weight => _weight;

  List<WeightModel> weight_with_date = WeightOnDate.weightDate.map((e) => WeightModel.fromMap(e)).toList();

  void setCreatedAt(DateTime datetime) {
    _created_at = datetime;
    update();
  }

  void sortByDate() {
    weight_with_date.sort((a,b) => a.date.compareTo(b.date));
    update();
    print("weight_with_date:  ${weight_with_date}");
  }

  void setWeight(double weight) {
    _weight = weight;
    update();
  }

  void submitWeight() {
    weight_with_date.add(WeightModel(weight: _weight, date: created_at));
    update();
  }
}
