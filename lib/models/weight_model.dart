// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeightModel {
  double weight;
  DateTime date;
  WeightModel({
    required this.weight,
    required this.date,
  });

  WeightModel copyWith({
    double? weight,
    DateTime? date,
  }) {
    return WeightModel(
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weight': weight,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      weight: map['weight'].toDouble(),
      date: DateTime.parse(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeightModel.fromJson(String source) => WeightModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeightModel(weight: $weight, date: $date)';

  @override
  bool operator ==(covariant WeightModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.weight == weight &&
      other.date == date;
  }

  @override
  int get hashCode => weight.hashCode ^ date.hashCode;
}
