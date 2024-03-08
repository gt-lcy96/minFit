import 'package:get/get.dart';

class WeightController extends GetxController {
  DateTime _created_at = DateTime.parse('2024-03-03 00:00:00.000');
  DateTime get created_at => _created_at;

  double _weight = 75;
  double get weight => _weight;

  void setCreatedAt(DateTime datetime) {
    _created_at = datetime;
    update();
  }

  void setWeight(double weight) {
    _weight = weight;
    update();
  }
}
