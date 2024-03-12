import 'package:min_fitness/models/weight_model.dart';

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitHours = twoDigits(duration.inHours.remainder(24));
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  return '$twoDigitHours:$twoDigitMinutes';
}

DateTime convertDoubleToDate(double value, DateTime referenceDate) {
  // Assuming the value is the number of days since referenceDate
  return referenceDate.add(Duration(days: value.toInt()));
}

List<WeightModel> fillInDates(List<WeightModel> data) {
  List<WeightModel> filledData = [];
  DateTime today = DateTime.now();

  for (var i = 0; i < data.length - 1; i++) {
    DateTime currentDate = data[i].date;
    filledData.add(data[i]);

    DateTime nextDate = data[i + 1].date;
    int daysApart = nextDate.difference(currentDate).inDays;

    for (var j = 1; j < daysApart; j++) {
      DateTime fillDate = currentDate.add(Duration(days: j));
      filledData.add(WeightModel(
        date: DateTime.parse('${fillDate.year.toString().padLeft(4, '0')}-${fillDate.month.toString().padLeft(2, '0')}-${fillDate.day.toString().padLeft(2, '0')}'),
        weight: data[i].weight,
      ));
    }
  }

  // Add the last entry from the original data
  filledData.add(data.last);

  // Fill in the remaining days after the last entry until today's date
  DateTime lastDataDate = data.last.date;
  DateTime startDate = lastDataDate.add(Duration(days: 1));
  while (startDate.isBefore(today)) {
    filledData.add(WeightModel(
      date: DateTime.parse('${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}'),
      weight: data.last.weight,
    ));
    startDate = startDate.add(Duration(days: 1));
  }

  return filledData;
}

