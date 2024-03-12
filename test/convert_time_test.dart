import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:min_fitness/helper/convert_time.dart';
import 'package:min_fitness/models/weight_model.dart';

void main() {  
  String getDateString(DateTime datetime) {
    return datetime.toString().substring(0, 10);
  }
  
  test('fillInDates adds missing dates up to today', () {
    final inputData = [
      {'date': '2024-01-15', 'weight': 72},
      {'date': '2024-02-16', 'weight': 73},
      {'date': '2024-02-28', 'weight': 75},
    ];
    List<WeightModel> inputModel = inputData.map((e) => WeightModel.fromMap(e)).toList();
    final result = fillInDates(inputModel);
    
    // Check the first date
    expect(getDateString(result.first.date), equals('2024-01-15'));
    expect(result.first.weight, equals(72));
    
    // Check one date in the middle
    final middleDate = DateTime(2024, 1, 15).add(Duration(days: 10)).toString().substring(0, 10);
    final middleWeight = result.where((entry) => getDateString(entry.date) == middleDate).first.weight;
    expect(middleWeight, equals(72));

    // Check the last date is today's date
    final todayString = getDateString(DateTime.now());
    // .toString().substring(0, 10);
    expect(getDateString(result.last.date), equals(todayString));
    
    // Check the weight of the last date is the same as the last input date's weight
    expect(result.last.weight, equals(75));
  });

  group('fillInDates function', () {
    test('should fill in dates and weights correctly including leap year', () {
      final inputData = [
        {'date': '2024-02-27', 'weight': 73}, // Leap year case
        {'date': '2024-03-01', 'weight': 74},
      ];
      List<WeightModel> inputModel = inputData.map((e) => WeightModel.fromMap(e)).toList();
      final result = fillInDates(inputModel);

      // Ensure February 29th is included
      var leapDayFound = result.any((day) => getDateString(day.date) == '2024-02-29');
      expect(leapDayFound, isTrue);
      // // Check leap year date
      // expect(result[1]['date'], equals('2024-02-28'));
      // expect(result[1]['weight'], equals(73));

      // // Check if March 1st is correctly placed after February 29th (leap year)
      // expect(result[2]['date'], equals('2024-03-01'));
      // expect(result[2]['weight'], equals(74));
    });

    test('should continue weight until the next entry', () {
      final inputData = [
        {'date': '2024-04-15', 'weight': 70},
        {'date': '2024-04-20', 'weight': 71},
      ];
      List<WeightModel> inputModel = inputData.map((e) => WeightModel.fromMap(e)).toList();
      final result = fillInDates(inputModel);

      // Check continuity of weight values
      expect(getDateString(result[3].date), equals('2024-04-18'));
      expect(result[3].weight, equals(70));
      expect(getDateString(result[4].date), equals('2024-04-19'));
      expect(result[4].weight, equals(70));

      // Check the date when weight changes
      expect(getDateString(result[5].date), equals('2024-04-20'));
      expect(result[5].weight, equals(71));
    });

    test('should handle consecutive days correctly', () {
      final inputData = [
        {'date': '2024-05-01', 'weight': 68},
        {'date': '2024-05-02', 'weight': 69},
        {'date': '2024-05-03', 'weight': 70},
      ];
      List<WeightModel> inputModel = inputData.map((e) => WeightModel.fromMap(e)).toList();
      final result = fillInDates(inputModel);

      // Check consecutive days
      expect(getDateString(result[0].date), equals('2024-05-01'));
      expect(result[0].weight, equals(68));
      expect(getDateString(result[1].date), equals('2024-05-02'));
      expect(result[1].weight, equals(69));
      expect(getDateString(result[2].date), equals('2024-05-03'));
      expect(result[2].weight, equals(70));
    });

    // test('should fill up to the current date', () {
    //   final inputData = [
    //     {'date': '2024-06-01', 'weight': 72},
    //     // {'date': '2024-06-15', 'weight': 73},
    //   ];
    //   final todayString = DateTime.now().toString().substring(0, 10);
    //   final result = fillInDates(inputData);

    //   // Check the last date is today's date
    //   expect(result.last['date'], equals(todayString));
      
    //   // Check the weight of the last date is the same as the last input date's weight
    //   // expect(result.last['weight'], equals(73));
    // });
  });
}
