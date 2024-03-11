import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:min_fitness/helper/convert_time.dart';

void main() {  
  
  test('fillInDates adds missing dates up to today', () {
    final inputData = [
      {'date': '2024-01-15', 'weight': 72},
      {'date': '2024-02-16', 'weight': 73},
      {'date': '2024-02-28', 'weight': 75},
    ];
    final result = fillInDates(inputData);
    
    // Check the first date
    expect(result.first['date'], equals('2024-01-15'));
    expect(result.first['weight'], equals(72));
    
    // Check one date in the middle
    final middleDate = DateTime(2024, 1, 15).add(Duration(days: 10)).toString().substring(0, 10);
    final middleWeight = result.where((entry) => entry['date'] == middleDate).first['weight'];
    expect(middleWeight, equals(72));

    // Check the last date is today's date
    final todayString = DateTime.now().toString().substring(0, 10);
    expect(result.last['date'], equals(todayString));
    
    // Check the weight of the last date is the same as the last input date's weight
    expect(result.last['weight'], equals(75));
  });
}
